# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/assp/assp-1.3.3.8-r2.ebuild,v 1.5 2009/12/19 18:54:45 vostorga Exp $

inherit eutils

DESCRIPTION="Anti-Spam SMTP Proxy written in Perl."
HOMEPAGE="http://assp.sourceforge.net/"
MY_PN=ASSP_${PV}-Install
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}.zip"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 x86"

IUSE="ldap spf srs"

DEPEND="app-arch/unzip"

RDEPEND="dev-lang/perl
	dev-perl/Net-DNS
	dev-perl/File-ReadBackwards
	virtual/perl-IO-Compress
	dev-perl/Email-Valid
	dev-perl/libwww-perl
	virtual/perl-Digest-MD5
	virtual/perl-Time-HiRes
	spf? ( dev-perl/Mail-SPF-Query )
	srs? ( dev-perl/Mail-SRS )
	ldap? ( dev-perl/perl-ldap )"

S=${WORKDIR}/${MY_PN}/ASSP

pkg_setup() {
	enewgroup assp
	enewuser assp -1 -1 /dev/null assp
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	local FILES="
		assp.pl
		move2num.pl
		rebuildspamdb.pl
		repair.pl
		stats.sh
		stat.pl
	"
	# just being safe
	for file in ${FILES}; do
		edos2unix ${file}
	done

	# portable changes via sed vs patch
	sed -i -e 's|file:files/|file:/etc/assp/|' \
		-e 's|$base/images|/usr/share/assp/images|' \
		-e 's|logs/maillog.txt|/var/log/assp/maillog.txt|' \
		-e 's|PID File'\'',40,textinput,'\''pid'\''|PID File'\'',40,textinput,'\''asspd.pid'\''|' \
		-e 's|Daemon\*\*'\'',0,checkbox,0|Daemon\*\*'\'',0,checkbox,1|' \
		-e 's|UID\*\*'\'',20,textinput,'\'''\''|UID\*\*'\'',20,textinput,'\''assp'\''|' \
		-e 's|GID\*\*'\'',20,textinput,'\'''\''|GID\*\*'\'',20,textinput,'\''assp'\''|' \
		-e 's|popFileEditor'\('\\'\''pb/pbdb\.\([^\.]*\)\.db\\'\'',|popFileEditor(\\'\''/var/lib/assp/pb/pbdb.\1.db\\'\'',|g' \
		-e 's|$base/assp.cfg|/etc/assp/assp.cfg|g' \
		-e 's|$base/$pidfile|/var/run/assp/asspd.pid|' \
		-e 's|mkdir "$base/$logdir",0700 if $logdir;||' \
		-e 's|mkdir "$base/$logdir",0700;||' \
		-e 's|$base/$logfile|$logfile|' \
		-e 's|$base/$logdir|$logdir|' \
		-e 's|"maillog.log"|"/var/log/assp/maillog.log"|' \
		-e 's|-d "$base/logs" or mkdir "$base/logs",0700;||' \
		-e 's|-d "$base/notes" or mkdir "$base/notes",0700;||' \
		-e 's|-d "$base/docs" or mkdir "$base/docs",0777;||' \
		-e 's|$base/$archivelogfile|$archivelogfile|' \
		-e 's|"$base/$file",$sub,"$this|"/etc/assp/$file",$sub,"$this|' \
		-e 's|"$base/$file",'\'''\'',"$this|"/etc/assp/$file",'\'''\'',"$this|' \
		-e 's|my $fil=$1; $fil="$base/$fil" if $fil!~/^\\Q$base\\E/i;|my $fil=$1;|' \
		-e 's|$fil="$base/$fil" if $fil!~/^\\Q$base\\E/i;|$fil="/etc/assp/$fil" if $fil!~/^\\/etc\\/assp\\/\|\\/var\\/lib\\/assp\\/\/i;|' \
		-e 's|$fil="$base/$fil" if $fil!~/^((\[a-z\]:)?\[\\/\\\\\]\|\\Q$base\\E)/;||' \
		-e 's|if ($fil !~ /^\\Q$base\\E/i) {|if ($fil !~ /^\\/usr\\/share\\/assp\\//i) {|' \
		-e 's|$fil="$base/$fil";|$fil="/usr/share/assp/$fil";|' \
		-e 's|Q$base\\E|Q\\/etc\\/assp\\/\\E|' \
		-e 's|$fil="$base/$fil"|$fil="/etc/assp/$fil"|' \
		-e 's|$base/$bf|/etc/assp/$bf|g' \
		-e 's|rebuildrun.txt|/var/lib/assp/rebuildrun.txt|' \
		assp.pl || die

	# questionable stuff
#		-e 's|$fil="$base/$fil" if $fil!~/^\\Q$base\\E/i;|$fil="/etc/assp/$fil" if $fil!~/^\\Q\\/etc\\/assp\\/\\E/i;|' \
#		-e 's|if ($fil !~ /^\\Q$base\\E/i) {|if ($fil !~ /^\\Q\\/usr\\/share\\/assp\\/\\E/i) {|' \
#		-e 's|split('\'' '\'', $this|split('\''$base/'\'', $this|' \
#		-e 's|split('\'' '\'',lc|split('\''$base/'\'',lc|' \
#		-e 's|split('\'' '\'',$pat)|split('\''$base/'\'',$pat)|' \

	# sed move2num.pl
	sed -i -e 's|assp.cfg|/etc/assp/assp.cfg|' move2num.pl || die

	# sed rebuildspamdb.pl
	sed -i -e 's|assp.cfg|/etc/assp/assp.cfg|' \
		-e 's|} && "$Config{base}/$Config{logfile}" \|\| '\''maillog.txt'\'';|};|' \
		-e 's|tmaxtick('\''rebuild'\'');|tmaxtick('\''/var/lib/assp/rebuild'\'');|' \
		-e 's|goodhosts|/var/lib/assp/goodhosts|g' \
		-e 's|rebuildrun.txt|/var/lib/assp/rebuildrun.txt|' \
		rebuildspamdb.pl || die

	# sed stats.sh
	sed -i -e 's|usr/local|var/log|' stats.sh || die

	# patch is against unix-format, so patch after dos2unix
	epatch "${FILESDIR}"/base.patch

	# remove windows stuff
	rm "${S}/addservice.pl" || die "Could not remove ${S}/addservice.pl"
	rm -f "${S}/Win32-quickstart-guide.txt" || die "Could not remove ${S}/Win32-quickstart-guide.txt"
}

src_install() {
	# Configuration directory
	dodir /etc/assp/notes

	insinto /etc/assp
	# Installs files that are used by assp for black/gray lists,
	# and domain country lookup. To be changed by admin as needed.
	doins files/*.txt || die

	fowners assp:assp /etc/assp -R
	fperms 770 /etc/assp /etc/assp/notes

	# Setup directories for mail to be stored for filter
	keepdir /var/lib/assp/spam /var/lib/assp/notspam
	keepdir /var/lib/assp/errors/spam /var/lib/assp/errors/notspam

	# Logs directory
	keepdir /var/log/assp
	fowners assp:assp -R /var/log/assp
	fperms 770 /var/log/assp

	# Install the app
	exeinto /usr/share/assp
	doexe *.pl *.sh || die
	insinto /usr/share/assp
	doins -r images/ || die

	# Lock down the files/data
	fowners assp:assp -R /usr/share/assp
	fperms 770 /usr/share/assp

	# Data storage
	fowners assp:assp -R /var/lib/assp
	fperms 770 /var/lib/assp

	# PID directory
	dodir /var/run/assp
	keepdir /var/run/assp
	fowners assp:assp -R /var/run/assp
	fperms 770 /var/run/assp

	# Install the init.d script to listen
	newinitd "${FILESDIR}/asspd.init" asspd

	dohtml docs/*.htm || die "Failed to install html docs"
}

pkg_postinst() {
	elog
	elog "To configure ASSP, start /etc/init.d/asspd then point"
	elog "your browser to http://localhost:55555"
	elog "Username: admin  Password: nospam4me (CHANGE ASAP!)"
	elog
	elog "File permissions have been set to use assp:assp"
	elog "with mode 770 on directories.  When you configure"
	elog "ASSP, make sure and use the user assp."
	elog
	elog "Don't change any path related options."
	elog
	elog "See the on-line docs for a complete tutorial."
	elog "http://assp.sourceforge.net/docs.html"
	elog
	elog "If upgrading, please update your old config to set both"
	elog "redre.txt and nodelay.txt path of /etc/assp.  There are"
	elog "also many new options that you should review."
	elog
}
