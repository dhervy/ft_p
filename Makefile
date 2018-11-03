# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhervy <dhervy@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/12/18 01:28:07 by dhervy            #+#    #+#              #
#    Updated: 2018/04/15 19:49:01 by dhervy           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAMESERVER = serveur
NAMECLIENT = client

CC = clang
CFLAGS = -Wall -Werror -Wextra

CPATH = srcs/
HPATH = includes/
CFILESSERVER = \
	main.c \

CFILESCLIENT = \
	main.c \

OPATHSERVER = obj/serveur/
OPATHCLIENT = obj/client/
OFILESSERVER = $(CFILESSERVER:.c=.o)
OFILESCLIENT = $(CFILESCLIENT:.c=.o)
OBJSERVER = $(addprefix $(OPATHSERVER), $(OFILESSERVER))
OBJCLIENT = $(addprefix $(OPATHCLIENT), $(OFILESCLIENT))

.PHONY: all clean fclean re

all: $(NAMESERVER) $(NAMECLIENT)

$(NAMESERVER): $(OBJSERVER)
	@echo "Compiling \"$(NAMESERVER)\"..."
	make -C libft
	$(CC) -g $(CFLAGS) $(OBJSERVER) -o$(NAMESERVER) -L libft -lft
	@echo "Successful compilation! $(NAMESERVER)\n---"

$(OPATHSERVER)%.o: $(CPATH)%.c includes/ft_p.h
	@mkdir -p $(OPATHSERVER)
	$(CC) $(CFLAGS) -I inc -c -o $@ $<

$(NAMECLIENT): $(OBJCLIENT)
	@echo "Compiling \"$(NAMECLIENT)\"..."
	make -C libft
	$(CC) $(CFLAGS) $(OBJCLIENT) -o$(NAMECLIENT) -L libft -lft
	@echo "Successful compilation! $(NAMECLIENT) \n---"

$(OPATHCLIENT)%.o: $(CPATH)%.c includes/ft_p.h
	@mkdir -p $(OPATHCLIENT)
	$(CC) $(CFLAGS) -I inc -c -o $@ $<

clean:
	@echo "Deleting the directory /obj..."
	make -C libft clean
	@rm -f $(OBJSERVER)
	@rm -f $(OBJCLIENT)
	@echo "Deletion complete !"

fclean: clean
	@echo "Deleting binary "$(NAMECLIENT)"..."
	@echo "Deleting binary "$(NAMESERVER)"..."
	make -C libft fclean
	@rm -f $(NAMESERVER)
	@rm -f $(NAMECLIENT)
	@echo "Deletion complete !"/

re: fclean all
