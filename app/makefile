CC=gcc
CFLAGS=-I.
DEPS = hellomake.h

# A rule that all .o files depend on the .c file of the same name, and the files
# included in the DEPS macro
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

hellomake: hellomake.o hellofunc.o
	$(CC) -o hellomake.exe hellomake.o hellofunc.o
