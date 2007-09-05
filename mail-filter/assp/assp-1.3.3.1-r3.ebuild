# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/assp/assp-1.3.3.1-r3.ebuild,v 1.1 2007/09/05 18:38:08 wltjr Exp $

inherit eutils

DESCRIPTION="Anti-Spam SMTP Proxy written in Perl."
HOMEPAGE="http://assp.sourceforge.net/"
MY_PN=ASSP_${PV}-Install
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}.zip
	mirror://gentoo/${PF}.patch.tbz2"
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

	# fix upstrean error
	sed -i -e 's:if(PopB4SMTPMerak):if($PopB4SMTPMerak):' assp.pl || \
		die "Could not fix upstream bug with PopB4SMTPMerak -> $PopB4SMTPMerak"

	# patch is against unix-format, so patch after dos2unix
	epatch ${WORKDIR}/${PF}.patch

	# remove windows stuff
	rm "${S}/addservice.pl" || die "Could not remove ${S}/addservice.pl"
	rm -f "${S}/Win32-quickstart-guide.txt" || die "Could not remove ${S}/Win32-quickstart-guide.txt"
}

src_install() {
	# Configuration directory
	dodir /etc/assp

	insinto /etc/assp
	# Installs files that are used by assp for black/gray lists,
	# and domain country lookup. To be changed by admin as needed.
	doins files/*.txt

	fowners assp:assp /etc/assp -R
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
	doins *.txt

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
	elog "See the on-line docs for a complete tutorial."
	elog "http://assp.sourceforge.net/docs.html"
	elog
	elog "If upgrading, please update your old config to set both"
	elog "redre.txt and nodelay.txt path of /etc/assp.  There are"
	elog "also many new options that you should review."
	elog
}
