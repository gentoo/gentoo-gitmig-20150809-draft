# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/solfege/solfege-2.0.4.ebuild,v 1.1 2004/02/10 09:20:34 eradicator Exp $

inherit python

IUSE="gtkhtml gnome oss"
DESCRIPTION="GNU Solfege is a program written to help you practice ear training."
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=dev-lang/python-2.2
	>=x11-libs/gtk+-2.0
	>=dev-python/pygtk-2.0
	gnome? ( >=dev-python/gnome-python-2.0 )
	gtkhtml? ( =gnome-extra/libgtkhtml-2*
	>=dev-python/gnome-python-2.0 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=dev-lang/swig-1.3*
	sys-devel/gettext
	sys-apps/texinfo
	dev-libs/libxslt
	=app-text/docbook-xsl-stylesheets-1.62*"

S=${WORKDIR}/${P}

pkg_setup() {
	# die if user wants gtkhtml but it is not enable in gnome-python
	# (can't use a "python -c 'import gtkhtml2'" test because it imports gtk, 
	#  which needs X11, and breaks in console)
	use gtkhtml \
		&& python_version \
		&& [ ! -f ${ROOT}usr/lib/python${PYVER}/site-packages/gtk-2.0/gtkhtml2.so ] \
		&& eerror "Could not find the GTKHtml2 python module, whereas gtkhml is in your flags." \
		&& eerror "Please re-emerge \"dev-python/gnome-python\" with \"gtkhtml\" USE flag on." \
		&& die "You will have to re-emerge gnome-python."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile.in Makefile.in.orig
	sed -e 's:links:#links: ; s:gnome/apps/Applications:applications:' \
		< Makefile.in.orig > Makefile.in

	echo 'Categories=Application;AudioVideo;' >> solfege.desktop
	echo 'Comments=The GNU ear training program' >> solfege.desktop
}

src_compile() {
	# Try to figure out where is this damn stylesheet
	local xslloc=$( ls /usr/share/sgml/docbook/xsl-stylesheets-1.62*/html/chunk.xsl | tail -n 1 )
	[ -n "$xslloc" ] || die "XSL stylesheet not found"

	econf --enable-docbook-stylesheet=${xslloc} \
		`use_with gnome` \
		`use_with gtkhtml` \
		`use_enable oss oss-sound` \
		|| die "Configuration failed."

	emake || die "Compilation failed."
}

src_install() {
#borks	make DESTDIR=${D} install || die "Installation failed."
	einstall || die "Installation failed."
	rm -f ${D}usr/bin/${PN}${PV}
	dodoc AUTHORS changelog COPYING FAQ INSTALL README TODO TRANSLATING
}

