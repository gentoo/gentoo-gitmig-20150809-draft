# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsampler/qsampler-0.1.0.ebuild,v 1.7 2007/07/11 19:30:24 mr_bones_ Exp $

inherit kde eutils

DESCRIPTION="QSampler is a graphical frontent to the LinuxSampler engine."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""
RDEPEND="=x11-libs/qt-3*
	>=media-libs/liblscp-0.2.9
	>=media-libs/libgig-2.0.0
	media-libs/alsa-lib"

DEPEND="${RDEPEND}"
#S="${WORKDIR}/${PN}"

src_compile() {
	econf || die "./configure failed"

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

	emake || die "make failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog README
}
