# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/assp/assp-1.2.5.ebuild,v 1.2 2006/11/19 06:00:30 wltjr Exp $

inherit eutils

DESCRIPTION="Anti-Spam SMTP Proxy written in Perl."
HOMEPAGE="http://assp.sourceforge.net/"
MY_PN=ASSP
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_${PV}-Install.zip"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="ldap spf srs"

DEPEND="app-arch/unzip"

RDEPEND="dev-lang/perl
	dev-perl/Net-DNS
	dev-perl/File-ReadBackwards
	dev-perl/Compress-Zlib
	dev-perl/Email-Valid
	virtual/perl-Digest-MD5
	perl-core/Time-HiRes
	spf? ( dev-perl/Mail-SPF-Query )
	srs? ( dev-perl/Mail-SRS )
	ldap? ( dev-perl/perl-ldap )"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
	enewgroup assp
	enewuser assp -1 -1 /dev/null assp
}

src_unpack() {
	unpack ${A}

	# Replace path for assp.pl to find data files
	# Convert PC line returns to Unix
	sed -i -e "/foreach /s:('.':('/var/lib/assp/':" \
		-e 's:$base/$pidfile:/var/run/assp/$pidfile:' \
		-e "s:'pid':'asspd.pid':" \
		-e "s:'maillog.txt':'/var/log/assp/maillog.txt':" \
		-e 's:"maillog.log":"/var/log/assp/maillog.log":' \
		-e 's:"$base/$logdir":"$logdir":' \
		-e 's:$base/$logfile:$logfile:' \
		-e 's:$base/assp.cfg:/etc/assp/assp.cfg:' \
		-e 's:$base/assp.cfg:/etc/assp/assp.cfg:' \
		-e 's:"$base/$archivelogfile":"$archivelogfile":' \
		-e 's:$base/images:/usr/share/assp/images:' \
		-e 's:$fil="$base/$fil";:$fil="/usr/share/assp/$fil";:' \
		-e 's:"$base/$maillog/:"/var/log/assp/$maillog/:' \
		-e "/AsADaemon,'As a Daemon',0,checkbox/s:checkbox,0,:checkbox,1,:" \
		-e "s:runAsUser,'Run as UID',20,textinput,'':runAsUser,'Run as UID',20,textinput,'assp':" \
		-e "s:runAsGroup,'Run as GID',20,textinput,'':runAsGroup,'Run as GID',20,textinput,'assp':" \
		-e ":[AvPath,':s:'':/var/lib/clamav/:" \
		-e 's/\r//' \
		"${S}"/assp.pl || die "sed failed"

# Security fix - allow only css/gif/jpg/png files
#		-e '/($fil=/s:$fil=.*):$fil!~/usr/share/assp/.*\\.(css|gif|jpg|png)$/i):' \

	# move2num.pl
	sed -i -e 's:assp.cfg:/etc/assp/assp.cfg:' \
		"${S}/move2num.pl" || die "sed failed"

	# rebuildspamdb.pl
	sed -i -e 's:assp.cfg:/etc/assp/assp.cfg:' \
		-e "s:'maillog.txt';::" \
		-e 's:$Log=$Config{logfile} && "$Config{base}/$Config{logfile}" || :$Log=$Config{logfile}:' \
		"${S}/rebuildspamdb.pl" || die "sed failed"

	# Replace path for default maillog.log
	sed -i -e 's:/usr/local/:/var/log/assp/:' "${S}/stats.sh" \
		|| die "sed failed"

	# rename utils
	mv "${S}"/stats.sh "${S}"/asspstats.sh
	mv "${S}"/stat.pl "${S}"/asspstat.pl
	mv "${S}"/repair.pl "${S}"/assprepair.pl
	mv "${S}"/rebuildspamdb.pl "${S}"/assprebuildspamdb.pl
	mv "${S}"/move2num.pl "${S}"/asspmove2num.pl

	# remove windows stuff
	rm "${S}"/addservice.pl
	rm -f "${S}/Win32-quickstart-guide.txt"
}

src_install() {
	# Configuration directory
	dodir /etc/assp
	fowners assp:assp /etc/assp
	fperms 770 /etc/assp

	# Setup directories for mail to be stored for filter
	keepdir /var/lib/assp/spam /var/lib/assp/notspam
	keepdir /var/lib/assp/errors/spam /var/lib/assp/errors/notspam

	# Logs directory
	keepdir /var/log/assp
	fowners assp:assp -R /var/log/assp
	fperms 770 /var/log/assp

	# Install the app
	exeinto /usr/share/assp
	doexe *.pl *.sh
	insinto /usr/share/assp
	doins -r images/
	insinto /var/lib/assp
	doins *.txt *.sav

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

	dohtml *.htm
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
	elog "All utilities are prefixed with assp."
	elog
	elog "See the on-line docs for a complete tutorial."
	elog
}
