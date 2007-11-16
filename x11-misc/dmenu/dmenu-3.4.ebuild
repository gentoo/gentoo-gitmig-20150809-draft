# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-3.4.ebuild,v 1.1 2007/11/16 20:44:15 cedk Exp $

inherit toolchain-funcs savedconfig

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/view.sh/x+tools"
SRC_URI="http://suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS = -Os/CFLAGS += -g/" \
		-e "s/LDFLAGS = -s/LDFLAGS += -g/" \
		config.mk || die "sed failed"

	if use savedconfig; then
		restore_config config.h
	fi
}

src_compile() {
	local msg
	use savedconfig && msg=", please check the configfile"
	emake CC=$(tc-getCC) || die "emake failed${msg}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	insinto /usr/share/${PN}
	newins config.h ${PF}.config.h

	dodoc README

	save_config config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
}
