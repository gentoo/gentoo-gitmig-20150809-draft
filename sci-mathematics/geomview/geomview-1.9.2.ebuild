# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/geomview/geomview-1.9.2.ebuild,v 1.9 2010/10/10 21:49:01 ulm Exp $

EAPI=1

inherit eutils flag-o-matic fdo-mime

DESCRIPTION="Interactive Geometry Viewer"
SRC_URI="http://mesh.dl.sourceforge.net/sourceforge/geomview/${P/_/-}.tar.bz2"
HOMEPAGE="http://geomview.sourceforge.net"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="avg bzip2 debug emacs netpbm pdf zlib"

DEPEND="zlib? ( sys-libs/zlib )
	>=x11-libs/openmotif-2.3:0
	virtual/opengl"

RDEPEND="${DEPEND}
	netpbm? ( >=media-libs/netpbm-10.37.0 )
	bzip2? ( app-arch/bzip2 )
	app-arch/gzip
	pdf? ( || ( app-text/xpdf
		app-text/gv
		app-text/gsview
		app-text/epdfview
		app-text/acroread )
		)
	virtual/w3m"

S="${WORKDIR}/${P/_/-}"

src_compile() {
	# GNU standard is /usr/share/doc/${PN}, so override this; also note
	# that motion averaging is still experimental.
	if use pdf; then
		local myconf="--docdir=/usr/share/doc/${PF}"
	else
		local myconf="--docdir=/usr/share/doc/${PF} --without-pdfviewer"
	fi

	econf ${myconf} $(use_enable debug d1debug) $(use_with zlib) \
		$(use_enable avg motion-averaging) \
		|| die "could not configure"

	make || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon "${FILESDIR}"/geomview.png
	make_desktop_entry geomview "GeomView ${PV}" \
		"/usr/share/pixmaps/geomview.png" \
		"Science;Math;Education"

	dodoc AUTHORS ChangeLog NEWS INSTALL.Geomview

	if ! use pdf; then
		rm "${D}"usr/share/doc/${PF}/${PN}.pdf
	fi

	if use emacs; then
		insinto /usr/share/geomview
		doins "${FILESDIR}"/gvcl-mode.el || die
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog "GeomView expects you to have both Firefox and Xpdf installed for"
	elog "viewing the documentation (this can be changed at runtime)."
	elog ""
	elog "The w3m virtual should handle the HTML borwser part, and if"
	elog "you wish to use an alternate PDF viewer, feel free to remove"
	elog "xpdf and use the viewer of your choice (see the docs for how"
	elog "to setup the \'(ui-pdf-viewer VIEWER)\' GCL-command)."
	elog ""
	elog "If you use emacs, enable the corresponding use flag and check"
	elog "out the provided mode file for editing the GeomView command"
	elog "language (courtesy of Claus-Justus Heine).  Incorporating it"
	elog "into your emacs configuration is left as an exercise..."
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
