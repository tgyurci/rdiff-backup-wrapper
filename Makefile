prefix=/usr/local

all: backup.sh backuprc

backup.sh: backup.sh.in
	sed -e 's|@prefix@|${prefix}|g' < backup.sh.in > backup.sh

backuprc: backuprc.in
	sed -e 's|@prefix@|${prefix}|g' < backuprc.in > backuprc

install: backup.sh backuprc
	install -C -d -o root -g wheel -m 755 backup.sh ${prefix}/bin/backup
	install -C -d -o root -g wheel -m 755 backuprc ${prefix}/etc/backuprc.sample

clean:
	rm -f backup.sh backuprc
