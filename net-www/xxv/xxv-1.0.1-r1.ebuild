# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/xxv/xxv-1.0.1-r1.ebuild,v 1.4 2009/01/05 00:07:45 hd_brummy Exp $

inherit eutils

DESCRIPTION="WWW Admin for the VDR (Video Disk Recorder)"
HOMEPAGE="http://xxv.berlios.de/content/view/37/1/"
SRC_URI="mirror://berlios/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mplayer themes"

RDEPEND=">=media-video/vdr-1.2.6
	media-video/vdr2jpeg
	media-fonts/ttf-bitstream-vera
	dev-db/mysql
	virtual/perl-CGI
	virtual/perl-Digest-MD5
	virtual/perl-Getopt-Long
	virtual/perl-MIME-Base64
	virtual/perl-Time-HiRes
	virtual/perl-Compress-Zlib
	dev-perl/Config-Tiny
	dev-perl/Digest-HMAC
	dev-perl/Encode-Detect
	dev-perl/GD
	dev-perl/DateManip
	dev-perl/DBD-mysql
	dev-perl/DBI
	dev-perl/Event
	dev-perl/IO-Socket-INET6
	dev-perl/JSON
	dev-perl/Locale-gettext
	dev-perl/MP3-Info
	dev-perl/Net-Amazon
	dev-perl/Net-Telnet
	dev-perl/Net-XMPP
	dev-perl/Proc-ProcessTable
	dev-perl/TextToHTML
	dev-perl/Template-Toolkit
	dev-perl/SOAP-Lite
	dev-perl/XML-RSS
	themes? ( =x11-themes/${PN}-skins-${PV} )"

PDEPEND="mplayer? ( media-video/mplayer )"

SHAREDIR="/usr/share/${PN}"
LIBDIR="/usr/lib/${PN}"

DB_VERS="25"

pkg_setup() {

	if ! built_with_use dev-perl/GD png gif ; then
		echo
		eerror "Please recompile dev-perl/GD with"
		eerror "USE=\"png gif\""
		die "dev-perl/GD need png and gif support"
	fi

	if ! has_version "net-www/${PN}"; then
		echo
		einfo	"Before you install xxv at first time you should read"
		einfo	"http://www.vdr-wiki.de/wiki/index.php/Xxv  German only available"
		echo
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "${S}"/bin/xxvd \
		-e "s:debian:Gentoo:" \
		-e "s:/var/log/xxvd.log:/var/log/xxv/xxvd.log:" \
		-e "s:/var/run/xxvd.pid:/var/run/xxv/xxvd.pid:" \
		-e "s:\$RealBin/../lib:${LIBDIR}:" \
		-e "s:\$RealBin/../locale:${SHAREDIR}/locale:" \
		-e "s:\$RealBin/../lib/XXV/MODULES:${LIBDIR}/XXV/MODULES:" \
		-e "s:\$RealBin/../etc/xxvd.cfg:/etc/xxv/xxvd.cfg:" \
		-e "s:\$RealBin/../doc:/usr/share/doc/${P}:" \
		-e "s:HTMLDIR     => \"\$RealBin/../:HTMLDIR     => \"${SHAREDIR}/skins:" \
		-e "s:\$RealBin/../share/vtx:${SHAREDIR}/vtx:" \
		-e "s:\$RealBin/../lib/XXV/OUTPUT:${LIBDIR}/XXV/OUTPUT:" \
		-e "s:\$RealBin/../share/news:${SHAREDIR}/news:" \
		-e "s:\$RealBin/../contrib:${SHAREDIR}/contrib:" \
		-e "s:\$RealBin/../share/fonts/:/usr/share/fonts/:"

	sed -i "s:\$RealBin/../lib:${LIBDIR}:" ./locale/xgettext.pl
}

src_compile() {
:
}

src_install() {

	doinitd "${FILESDIR}"/xxv

	dobin	bin/xxvd

	insinto /etc/"${PN}"
	newins "${FILESDIR}"/xxvd-1.0.cfg xxvd.cfg

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/xxvd-logrotate xxvd

	diropts -m755 -ovdr -gvdr
	keepdir /var/cache/xxv
	keepdir /var/run/xxv
	keepdir /var/log/xxv

	insinto "${LIBDIR}"
	doins -r "${S}"/lib/*

	insinto "${SHAREDIR}"
	doins -r "${S}"/share/{news,vtx}

	insinto "${SHAREDIR}"/locale
	doins -r "${S}"/locale/*
	fperms 0755 "${SHAREDIR}"/locale/xgettext.pl

	insinto "${SHAREDIR}"/contrib
	doins -r "${S}"/contrib/*
	fperms 0755 "${SHAREDIR}"/contrib/update-xxv

	insinto "${SHAREDIR}"/skins
	doins -r "${S}"/{html,wml}
	doins "${S}"/doc/docu.tmpl

	cd "${S}"/doc
	insinto /usr/share/doc/"${P}"
	doins docu.tmpl CHANGELOG COPYING LIESMICH NEWS README TODO TUTORIAL.txt.gz
	fowners vdr:vdr /usr/share/doc/"${P}"

	doman xxvd.1
}

pkg_postinst() {

	if has_version "net-www/${PN}"; then
		if has_version "=<net-www/${PN}-0.91_pre1002" ; then
			echo
			einfo "An update of XXV Database is needed"
			echo
			einfo "emerge --config ${PN}"
			echo
			einfo "will update your XXV Database"
		fi
	else
		einfo "If this is a new install"
		einfo "you have to create a empty DB for XXV"
		echo
		einfo "do this by:"
		einfo "cd ${SHAREDIR}/contrib"
		eerror "read the README"
		einfo "edit create-database.sql and run"
		einfo "emerge --config ${PN}"
		echo
		einfo "Set your own language in"
		einfo "${SHAREDIR}/locale"
		echo
		einfo "For First Time Login in Browser use:"
		einfo "Pass:Login = xxv:xxv"
		echo
		eerror "edit /etc/xxv/xxvd.cfg !"
	fi
}

pkg_config() {

	if has_version "=<net-www/${PN}-0.91_pre1002"; then
		cd "${ROOT}"/"${SHAREDIR}"/contrib
		./update-xxv
	else
		cd "${ROOT}"/"${SHAREDIR}"
		cat ./contrib/create-database.sql | mysql -u root -p
	fi
}

pkg_postrm() {

	einfo "Cleanup for old "${P}" files"
	rm -r /usr/share/doc/"${P}"
}
