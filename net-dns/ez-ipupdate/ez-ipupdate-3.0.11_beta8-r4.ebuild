# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ez-ipupdate/ez-ipupdate-3.0.11_beta8-r4.ebuild,v 1.3 2007/10/05 13:33:21 opfer Exp $

inherit eutils

PATCH_VERSION="10"
MY_PV="${PV/_beta/b}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="Dynamic DNS client for lots of dynamic dns services"
HOMEPAGE="http://ez-ipupdate.com/"
SRC_URI="mirror://debian/pool/main/e/ez-ipupdate/${PN}_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/e/ez-ipupdate/${PN}_${MY_PV}-${PATCH_VERSION}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${PN}_${MY_PV}-${PATCH_VERSION}.diff"
	epatch "${FILESDIR}/${P}-dnsexit.diff"
	epatch "${FILESDIR}/${P}-3322.diff"

	# comment out obsolete options
	sed -i -e "s:^\(run-as-user.*\):#\1:g" \
		-e "s:^\(cache-file.*\):#\1:g" ex*conf
}

src_compile() {
	econf --bindir=/usr/sbin || "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}/ez-ipupdate.initd" ez-ipupdate
	keepdir /etc/ez-ipupdate /var/cache/ez-ipupdate

	# install docs
	dodoc README
	newdoc debian/README.Debian README.debian
	newdoc debian/changelog ChangeLog.debian
	newdoc CHANGELOG ChangeLog

	# install example configs
	docinto examples
	dodoc ex*conf
}

pkg_preinst() {
	enewgroup ez-ipupd
	enewuser ez-ipupd -1 -1 /var/cache/ez-ipupdate ez-ipupd
}

pkg_postinst() {
	chmod 750 /etc/ez-ipupdate /var/cache/ez-ipupdate
	chown ez-ipupd:ez-ipupd /etc/ez-ipupdate /var/cache/ez-ipupdate

	einfo
	einfo "Please create one or more config files in"
	einfo "/etc/ez-ipupdate/. A bunch of samples can"
	einfo "be found in the doc directory."
	einfo
	einfo "All config files must have a '.conf' extension."
	einfo
	einfo "Please do not use the 'run-as-user', 'run-as-euser',"
	einfo "'cache-file' and 'pidfile' options, since these are"
	einfo "handled internally by the init-script!"
	einfo
	einfo "If you want to use ez-ipupdate in daemon mode,"
	einfo "please add 'daemon' to the config file(s) and"
	einfo "add the ez-ipupdate init-script to the default"
	einfo "runlevel."
	einfo
	einfo "Without the 'daemon' option, you can run the"
	einfo "init-script with the 'update' parameter inside"
	einfo "your PPP ip-up script."
	einfo

	if [ -f /etc/ez-ipupdate.conf ]; then
		ewarn "!!! IMPORTANT UPDATE NOTICE !!!"
		ewarn
		ewarn "The ez-ipupdate init-script can now handle more"
		ewarn "than one config file. New config file location is"
		ewarn "/etc/ez-ipupdate/*.conf"
		ewarn
		if [ ! -f /etc/ez-ipupdate/default.conf ]; then
			mv -f /etc/ez-ipupdate.conf /etc/ez-ipupdate/default.conf
			einfo "Your old configuration has been moved to"
			einfo "/etc/ez-ipupdate/default.conf"
			einfo
		fi
		ebeep
	fi
}
