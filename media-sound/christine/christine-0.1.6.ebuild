# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/christine/christine-0.1.6.ebuild,v 1.1 2008/06/08 18:45:59 drac Exp $

inherit multilib python

DESCRIPTION="Python, GTK+ and GStreamer based media player (audio and video)"
HOMEPAGE="http://christine-project.org"
# It seems 0.x.x-1.tar.bz2 is 0.x.x release, deb lovers..
SRC_URI="mirror://sourceforge/${PN}/${P}-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="readline"

RDEPEND="readline? ( sys-libs/readline )
	>=dev-python/pygtk-2
	>=dev-python/gst-python-0.10
	>=media-plugins/gst-plugins-meta-0.10
	media-libs/mutagen"
DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

src_compile() {
	addpredict $(unset HOME; echo ~)/.gconf
	addpredict $(unset HOME; echo ~)/.gconfd
	addpredict $(unset HOME; echo ~)/.gstreamer-0.10
	econf --disable-dependency-tracking $(use_with readline)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# deb lovers again..
	rm -f "${D}"/createDeb.sh
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/lib${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/lib${PN}
}
