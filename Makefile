prefix=/usr/local
sed=/usr/bin/sed
rm=/bin/rm
cat=/bin/cat
rdiff_backup=/usr/local/rdiff-backup/bin/rdiff-backup

all: backup.sh backuprc

backup.sh: backup.sh.in
	sed -e 's|@prefix@|${prefix}|g' \
		-e 's|@sed@|${sed}|g' \
		-e 's|@rm@|${rm}|g' \
		-e 's|@cat@|${cat}|g' \
		-e 's|@rdiff_backup@|${rdiff_backup}|g' < backup.sh.in > backup.sh

backuprc: backuprc.in
	sed -e 's|@prefix@|${prefix}|g' < backuprc.in > backuprc

install: backup.sh backuprc
	install -d -o root -g wheel -m 755 ${prefix}/bin ${prefix}/etc 
	install -C -o root -g wheel -m 755 backup.sh ${prefix}/bin/backup
	install -C -o root -g wheel -m 644 backuprc ${prefix}/etc/backuprc.sample

clean:
	rm -f backup.sh backuprc
