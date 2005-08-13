# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_capi-cm/asterisk-chan_capi-cm-0.5.3.ebuild,v 1.2 2005/08/13 03:24:50 stkn Exp $

IUSE=""

inherit eutils

MY_P="chan_capi-cm-${PV}"

DESCRIPTION="Alternative CAPI2.0 channel module for Asterisk"
HOMEPAGE="http://sourceforge.net/projects/chan-capi"
SRC_URI="mirror://sourceforge/chan-capi/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

DEPEND="!net-misc/asterisk-chan_capi
	>=net-misc/asterisk-1.0.5-r2
	net-dialup/capi4k-utils"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/chan_capi-0.3.5-gentoo.diff

	# compile for asterisk-stable
	sed -i -e "s:^\(CFLAGS+=-DCVS_HEAD\):#\1:" \
		Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX=${D} install config || die "make install failed"

	dodoc INSTALL LICENSE README capi.conf

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk ${D}/etc/asterisk/capi.conf
		chmod -R u=rwX,g=rX,o= ${D}/etc/asterisk/capi.conf
	fi
}

pkg_postinst() {
	einfo "Please don't forget to enable chan_capi in your /etc/asterisk/modules.conf:"
	einfo ""
	einfo "load => chan_capi.so"
	einfo ""
	einfo "and in the [global] section:"
	einfo "chan_capi.so=yes"
	einfo ""
	einfo "(see /usr/share/doc/${PF} for more information)"
}
