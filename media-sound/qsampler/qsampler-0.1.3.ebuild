# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsampler/qsampler-0.1.3.ebuild,v 1.1 2007/08/19 19:16:55 drac Exp $

DESCRIPTION="QSampler is a graphical frontend to the LinuxSampler engine."
HOMEPAGE="http://www.linuxsampler.org"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=x11-libs/qt-3*
	>=media-libs/liblscp-0.3
	>=media-libs/libgig-3
	>=media-sound/linuxsampler-0.4
	media-libs/alsa-lib"
DEPEND="${RDEPEND}"

src_compile() {
	econf

	# Fix sandbox errors by borrowing from kde.eclass.
	REALHOME="$HOME"
	mkdir -p "${T}"/fakehome/.kde
	mkdir -p "${T}"/fakehome/.qt
	export HOME="${T}"/fakehome
	addwrite "${QTDIR}"/etc/settings

	# Things that should access the real homedir.
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"

	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
	doman debian/${PN}.1
}
