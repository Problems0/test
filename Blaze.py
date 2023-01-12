import requests
import json
from requests import get
from time import sleep
import telebot

# variaveis globais
jogos = []  # os jogos
estrategias = []  # as estrategias


token = '5709702288:AAGAhqbXcLi9Eiz0Kvl_N4Ms-f5FlEGOz9o'
# grupos dos sinais                  ##### LUCRANDO NA BLAZE
grupo = ['-1001878886587']

bot = telebot.TeleBot(token)
##########################################################################

link = f"https://api.telegram.org/bot{token}/"
stop2 = False


# grupo_pv = ['-894686989']  # grupos dos logs de acertividade e erros no codigo

##########################################################################

chat = grupo[0]

def manda_msg(msg: str, chats: list=grupo): # envia mensagem pros grupos
  global token
  for chat in chats:
    get(f"{link}sendMessage?chat_id={chat}&text={msg}")

def ns(estrategia: list, aposta: list): # função para adicionar as estrategias
  global estrategias
  estrategias.append({'sequencia': estrategia, 'aposta': aposta})

ns([0,], ['v', 'b'])  # 0
ns([1,], ['v', 'b'])  # 1
ns([2,], ['p', 'b'])  # 2
ns([3,], ['v', 'b'])  # 3
ns([4,], ['v', 'b'])  # 4
ns([5,], ['p', 'b'])  # 5
ns([6,], ['v', 'b'])  # 6
ns([7,], ['p', 'b'])  # 7
ns([8,], ['v', 'b'])  # 8
ns([9,], ['v', 'b'])  # 9
ns([10,], ['v', 'b'])  # 10
ns([11,], ['p', 'b'])  # 11
ns([12,], ['v', 'b'])  # 12
ns([13,], ['v', 'b'])  # 13
ns([14,], ['v', 'b'])  # 14
ns([15,], ['v', 'b'])  # 0

def mensagem(msg):
  while True:
    try:
      return get(f"{link}sendMessage?chat_id={chat}&text={msg}").json()
    except:
      pass

def ouve():

  mensagens = []

  while True:
    try:
      r = get(f'{link}getUpdates').json()
      resultados = r['result']
      break
    except:
      pass

  for resultado in resultados:
    try:
      mensagens.append({'update_id': resultado['update_id'], 'from_id': resultado['message']['from']['id'], 'chat_id': resultado['message']['chat']['id'], 'text': resultado['message']['text']})
    except:
      pass

  ids = []
  for mensagem in mensagens:
    r = comandos(mensagem['text'], mensagem)
    if r:
      ids.append(mensagem["update_id"])

  for idm in ids:
    while True:
      try:
        r = get(f'{link}getUpdates?offset={int(idm)+1}').json()
        break
      except:
        pass

def comandos(text, conteudo):
  global chat
  global stop2

  if text == '/informacao':
    while True:
      try:
        return get(f"{link}sendMessage?chat_id={conteudo['chat_id']}&text={str(conteudo)}").json()
      except:
        pass

  if conteudo['chat_id'] == int(chat):

    if conteudo['from_id'] == 5514566795:

      if text == '/help-adm':
        mensagem('comandos restritos:\n\n/atualizar - para atualizar o bot manualmente')

      if text == '/atualizar':
        mensagem('atualizando')
        stop2 = True
        
#       if text == '/topadm':
#         melhores = logs.copy()
#         quantidade = len(logs)

#         aqui = dict(sorted(melhores.items(), key=lambda dados: dados[1]['acertividade'] - dados[1]['red'], reverse=True))
        
#         if not aqui:
#           mensagem('poucos dados para fazer o top...\ntente novamente mais tarde')
#           return True

#         texto = f'as top das {quantidade} estratégias:\n'

#         for n, dados in enumerate(aqui.items()):
#           nestrategia = None

#           for numero, log in enumerate(logs):
#             if dados[0] == log:
#               nestrategia = numero+1
#               break
          
#           texto += f'{dados[1]["acertividade"]}% - nº:{nestrategia}, g:{dados[1]["green"]}, b:{dados[1]["green branca"]}, r:{dados[1]["red"]}\n'

#         while True:
#           try:
#             return get(f"{link}sendMessage?chat_id={conteudo['from_id']}&text={texto}").json()
#           except:
#             pass

    elif text in ['/help-adm', '/atualizar']:
      mensagem('você não tem permissão suficiente')

    if text == '/teste':
      mensagem('funcionando!')

    if text == '/help':
      mensagem('''os comandos atuais são:

/help-adm - para ver os comandos de adm
/teste - para ver se o bot ta funcionando
''')

    return True

def atualizador(): # faz loop para atualizar os jogos da blaze
  global jogos
  global stop2
  sleep(1)
  while True:
    ouve()
    if verifica_mudanca():
      jogos = pega_lista()
      verifica_estrategias()
    if stop2:
      break

def verifica_mudanca() -> bool: # verifica se mudou a lista
  global jogos
  while True:
    ouve()
    if jogos == pega_lista():
      sleep(1)
      continue
    else:
      return True

def pega_lista() -> list[object]: # pega os jogos da blaze e retorna
  while True:
    try:
      lista = []
      r = get('https://blaze.com/api/roulette_games/recent')
      for jogada in r.json():
        lista.append({'cor': jogada['color'], 'numero': jogada['roll']})
      return lista
    except:
      continue

def entrada(aposta: list, cor: int, chave: str): # é executado quando é encontrado uma entrada
  global jogos

  if 'v' in aposta:
    str_aposta = '🔴'
  elif 'p' in aposta:
    str_aposta = '⚫'
  elif 'o' in aposta:
    str_aposta = '🔴' if cor == 2 else '⚫'
  elif 'i' in aposta:
    str_aposta = '🔴' if cor == 1 else '⚫'
  
  if 'b' in aposta:
    str_aposta += '\n✴️ 𝗣𝗥𝗢𝗧𝗘𝗚𝗘𝗥 𝗡𝗔 𝗖𝗢𝗥  ⚪\n️️\n♻️𝐑𝐄𝐀𝐋𝐈𝐙𝐀𝐑 𝐀𝐓É 𝟐 🐔 𝐌𝐀𝐑𝐓𝐈𝐍𝐆𝐀𝐋𝐄!'

  manda_msg(f'🔔 𝙀𝙉𝙏𝙍𝘼𝘿𝘼 𝘾𝙊𝙉𝙁𝙄𝙍𝙈𝘼𝘿𝘼 🔔 \n\n✴️𝗔𝗣𝗢𝗦𝗧𝗘 𝗡𝗔 𝗖𝗢𝗥 {str_aposta}')

  gale = 0
  max_gale = 2                   # escolher a quantidade de gale que o bot vai mandar
  green = False
  while True:
    if verifica_mudanca() == True:
      jogos = pega_lista()

      if 'b' in aposta and jogos[0]['cor'] == 0:
        green = True

      elif 'v' in aposta and jogos[0]['cor'] == 1:
        green = True

      elif 'p' in aposta and jogos[0]['cor'] == 2:
        green = True

      elif 'o' in aposta and jogos[0]['cor'] != 0 and jogos[0]['cor'] != cor:
        green = True

      elif 'i' in aposta and jogos[0]['cor'] != 0 and jogos[0]['cor'] == cor:
        green = True
      
      if green == True:
        if jogos[0]['cor'] == 0:
          bot.send_sticker(
              chat, sticker="CAACAgEAAxkBAAEBgzljkp23B09f0r6MZcJmqyMvO7QIsgACZwIAAiHIiURRseE-HAq3hisE")  # STCKER DO WIN PAGA BRANCO
          
          
          
        else:
          bot.send_sticker(
              chat, sticker="CAACAgEAAxkBAAEBgzVjkpzZaWSuw1tYwdyF442SkX3uQAADAgACEAaYR8Labhl27cGEKwQ")   # SITCKER DO WIN CORES
          
          
        break
      else:
        if gale == 2:
          bot.send_sticker(
              chat, sticker="CAACAgEAAxkBAAEGv7hjk0GMkP-rvTwO7quh343TimHZqAACgwIAAocFSUQVno-OHeLg2isE")  # LOOS
          verifica_estrategias()
          break
        if gale <= max_gale:
          gale += 1
          manda_msg(f'🔅 ENTRANDO NO {gale}° GALE')

def verifica_estrategias(): # verefica se há uma estrategia para ser executada
  global estrategias
  global jogos
  c1 = None
  c2 = None
  detec = True

  for estrategia in estrategias:
    estrategia['sequencia'].reverse()

    for x in zip(estrategia['sequencia'], jogos):
      
      if x[0] in ['c1', 'c2']: # se caso for por cor de cor 1 ou cor 2
        
        if x[0] == 'c1':
          if c1 == None:
            if x[1]['cor'] != 0:
              if c2 != x[1]['cor']:
                c1 = x[1]['cor']
              else:
                detec = False
                break    
            else:
              detec = False
              break
          else:
            if c1 != x[1]['cor']:
              detec = False
              break
            elif c1 == x[1]['cor']:
              continue

        elif x[0] == 'c2':
          if c2 == None:
            if x[1]['cor'] != 0:
              if c1 != x[1]['cor']:
                c2 = x[1]['cor']
              else:
                detec = False
                break
            else:
              detec = False
              break
          else:
            if c2 != x[1]['cor']:
              detec = False
              break
            elif c2 == x[1]['cor']:
              continue

      elif x[0] in ['v', 'p', 'q', 'b']: # se caso for por cor vermelho, preto, qualquer ou branco

        if x[0] == 'v' and x[1]['cor'] == 1:
          continue
        elif x[0] == 'p' and x[1]['cor'] == 2:
          continue
        elif x[0] == 'q':
          continue
        elif x[0] == 'b' and x[1]['cor'] == 0:
          continue
        else:
          detec = False
          break

      elif x[0] in [*range(1, 15)]: # se caso for por numero
        if x[0] == x[1]['numero']:
          continue
        else:
          detec = False
          break
    
    estrategia['sequencia'].reverse()

    if detec == True: # aqui sla
      cor = None
      if estrategia['sequencia'][-1] == 'b':
        if estrategia['sequencia'][-2] == 'b':
          cor = c1 if estrategia['sequencia'][-3] == 'c1' else c2
        else:
          cor = c1 if estrategia['sequencia'][-2] == 'c1' else c2
      else:
        cor = c1 if estrategia['sequencia'][-1] == 'c1' else c2
      entrada(estrategia['aposta'], cor, str(estrategia['sequencia']))
      break

    else:
      c1 = None
      c2 = None
      detec = True


ouve()
print('HORA DE LUCRAR EM!')
# STICKER DE INICIO DO BOT
bot.send_sticker(chat, sticker="CAACAgEAAxkBAAEGv7Zjkz-v6vbIQGdYmetvCK60GSEmfAADAgACXNfgRyK90zAGogZiKwQ") #sticker do iniciar
atualizador()
