# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetmon/wmnetmon-0.2_p5.ebuild,v 1.5 2008/11/28 18:57:54 tcunha Exp $

EAPI=1

inherit toolchain-funcs

DESCRIPTION="monitors up to 40 hosts/services and can execute a command if there are problems with them"
HOMEPAGE="http://freshmeat.net/projects/wmnetmon/?topic_id=876"
SRC_URI="http://www.linuks.mine.nu/dockapps/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="+suid"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${P/_/}

src_compile() {
	tc-export CC
	econf
	emake || die "emake failed."
}

src_install() {
	if use suid; then
		dobin ${PN}
		fperms 4755 /usr/bin/${PN}
	else
		dosbin ${PN}
	fi

	dodoc Changes README ${PN}rc
}

pkg_postinst() {
	elog "Extract ${PN}rc from /usr/share/doc/${PF} to your home directory."
	use suid || elog "Warning, ${PN} needs to be executed as root."
}
