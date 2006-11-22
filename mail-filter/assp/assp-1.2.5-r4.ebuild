# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/assp/assp-1.2.5-r4.ebuild,v 1.1 2006/11/22 19:00:28 wltjr Exp $

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
	cd "${S}"
	epatch ${FILESDIR}/assp-${PV}.patch

	local FILES="
		assp.pl
		freshclam.sh
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

	# remove windows stuff
	rm "${S}/addservice.pl"
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

