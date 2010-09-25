prefix=/usr/local
sed=/usr/bin/sed
rm=/bin/rm
cat=/bin/cat
rdiff_backup=/usr/local/rdiff-backup/bin/rdiff-backup

all: rbw.sh rbwrc

rbw.sh: rbw.sh.in
	sed -e 's|@prefix@|${prefix}|g' \
		-e 's|@sed@|${sed}|g' \
		-e 's|@rm@|${rm}|g' \
		-e 's|@cat@|${cat}|g' \
		-e 's|@rdiff_backup@|${rdiff_backup}|g' < rbw.sh.in > rbw.sh

rbwrc: rbwrc.in
	sed -e 's|@prefix@|${prefix}|g' < rbwrc.in > rbwrc

install: rbw.sh rbwrc
	install -d -o root -g wheel -m 755 ${prefix}/bin ${prefix}/etc 
	install -C -o root -g wheel -m 755 rbw.sh ${prefix}/bin/rbw
	install -C -o root -g wheel -m 644 rbwrc ${prefix}/etc/rbwrc.sample

clean:
	rm -f rbw.sh rbwrc
