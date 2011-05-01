# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_capi/asterisk-chan_capi-1.1.4.ebuild,v 1.2 2011/05/01 00:41:33 halcy0n Exp $

inherit eutils

DESCRIPTION="CAPI 2.0 channel module for Asterisk"
HOMEPAGE="http://www.melware.org/ChanCapi"
SRC_URI="ftp://ftp.chan-capi.org/chan-capi/${P/asterisk-}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-misc/asterisk-1.2.0
	net-dialup/capi4k-utils"

DEPEND="${RDEPEND}
	sys-apps/sed"

S="${WORKDIR}/${P/asterisk-}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch locations and compile flags
	sed -i \
		-e "s:^\(CFLAGS.*-O6.*\):# \1:g" \
		-e "s:^\(CFLAGS.*-march=.*\):# \1:g" \
		-e "s:/usr/lib/:/usr/$(get_libdir)/:g" \
		-e "s:\(-shared\):\$(LDFLAGS) \1:g" Makefile || die "sed failed"
}

src_compile() {
	emake V="1" CC="$(tc-getCC)" OPTIMIZE="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake AVERSION="" INSTALL_PREFIX="${D}" install install_config || die "emake install failed"
	newdoc libcapi20/README README.capi20 || die "newdoc failed"
	dodoc CHANGES README* capi.conf || die "dodoc failed"

	# fix permissions
	if [ -n "$(egetent group asterisk)" ]; then
		chown -R root:asterisk "${D}etc/asterisk/capi.conf"
		chmod -R u=rwX,g=rX,o= "${D}etc/asterisk/capi.conf"
	fi
}

pkg_postinst() {
	elog
	elog "Please don't forget to enable chan_capi in"
	elog "your /etc/asterisk/modules.conf:"
	elog
	elog "  load => chan_capi.so"
	elog
	elog "and in the [global] section:"
	elog
	elog "  chan_capi.so=yes"
	elog
	elog "Don't forget a trailing newline at the end of modules.conf!"
	elog "See /usr/share/doc/${PF} for more information."
	elog
}
