# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tktray/tktray-1.1.ebuild,v 1.3 2008/10/03 19:34:54 bluebird Exp $

MY_P="${PN}${PV}"
DESCRIPTION="tktray - System Tray Icon Support for Tk on X11"
HOMEPAGE="http://sw4me.com/wiki/Tktray"
SRC_URI="http://www.sw4me.com/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BWidget"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE="threads debug"

DEPEND=">=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	x11-libs/libXext"

src_compile() {
	source /usr/lib/tclConfig.sh
	CPPFLAGS="-I${TCL_SRC_DIR}/generic ${CPPFLAGS}" \
	econf \
		$(use_enable debug symbols) \
		$(use_enable threads) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
	dohtml doc/*.html
}
