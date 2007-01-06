# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_capi/asterisk-chan_capi-0.7.1.ebuild,v 1.2 2007/01/06 16:50:51 drizzt Exp $

inherit eutils toolchain-funcs

MY_P="${P/asterisk-}"

DESCRIPTION="CAPI 2.0 channel module for Asterisk"
HOMEPAGE="http://www.melware.org/ChanCapi"
SRC_URI="ftp://ftp.chan-capi.org/chan-capi/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="!net-misc/asterisk-chan_capi-cm
	>=net-misc/asterisk-1.2.0
	net-dialup/capi4k-utils"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch locations and compile flags
	sed -i -e "s:^\(CFLAGS.*-march=.*\):# \1:g" -e "s:^\(CFLAGS.*-O6.*\):# \1:g" \
		-e "s:^\(MODULES_DIR=[^/]*\).*:\1/usr/$(get_libdir)/asterisk/modules:g" \
		-e "s:^\(ASTERISK_HEADER_DIR=[^/]*\).*:\1/usr/include:g" \
		-e "s:^\(CONFIG_DIR=[^/]*\).*:\1/etc/asterisk:g" \
		-e "s:\(-shared\):\$(LDFLAGS) \1:g" Makefile
}

src_compile() {
	emake OPTIMIZE="${CFLAGS}" || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX="${D}" install install_config || die "make install failed"
	dodoc CHANGES INSTALL README capi.conf

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk "${D}"/etc/asterisk/capi.conf
		chmod -R u=rwX,g=rX,o= "${D}"/etc/asterisk/capi.conf
	fi
}

pkg_postinst() {
	echo
	elog "Please don't forget to enable chan_capi in"
	elog "your /etc/asterisk/modules.conf:"
	echo
	elog "load => chan_capi.so"
	echo
	elog "and in the [global] section:"
	elog "chan_capi.so=yes"
	echo
	elog "(see /usr/share/doc/${PF} for more information)"
	echo
}
