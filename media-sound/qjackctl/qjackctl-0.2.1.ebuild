# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.2.1.ebuild,v 1.2 2004/02/01 23:10:38 mholzer Exp $ 

IUSE=""

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit"
HOMEPAGE="http://qjackctl.sf.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.1.1
	virtual/jack"

src_compile() {
		econf || die

        ### borrowed from kde.eclass #
        #
        # fix the sandbox errors "can't writ to .kde or .qt" problems.
        # this is a fake homedir that is writeable under the sandbox,
        # so that the build process can do anything it wants with it.
        REALHOME="$HOME"
        mkdir -p $T/fakehome/.kde
        mkdir -p $T/fakehome/.qt
        export HOME="$T/fakehome"
        addwrite "${QTDIR}/etc/settings"

        # things that should access the real homedir
        [ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"
		
		emake || die
}

src_install() {
	einstall || die "make install failed"
}
