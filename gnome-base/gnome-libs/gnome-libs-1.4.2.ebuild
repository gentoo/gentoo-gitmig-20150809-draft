# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.4.2.ebuild,v 1.33 2006/07/05 05:36:12 vapier Exp $

inherit eutils libtool multilib autotools flag-o-matic

DESCRIPTION="GNOME Core Libraries"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/1.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="doc esd nls kde"

RDEPEND=">=media-libs/imlib-1.9.10
	esd? ( >=media-sound/esound-0.2.23 )
	=gnome-base/orbit-0*
	=x11-libs/gtk+-1.2*
	<=sys-libs/db-2
	doc? ( app-text/docbook-sgml
		dev-util/gtk-doc )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.40
		>=dev-util/intltool-0.11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	# Correct problems with documentation. See bug #44439.
	epatch "${FILESDIR}"/${P}-gtkdoc_fixes.patch
	# Fix compilation with GCC4 ; bug #94321
	epatch "${FILESDIR}"/${P}-gcc4.patch
	# Fix compilation with GCC4 on ppc64 ; bug #117750
	epatch "${FILESDIR}"/${P}-ppc64.patch
	eautoconf
}

src_compile() {
	append-flags -I/usr/include/db1

	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use kde && myconf="${myconf} --with-kde-datadir=/usr/share"
	use doc || myconf="${myconf} --disable-gtk-doc"
	use esd || export ESD_CONFIG=no

	# libtoolize
	elibtoolize

	./configure --host=${CHOST} \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-prefer-db1 \
		${myconf} || die

	# gnome-libs does not like parallel building, bug #117644
	emake -j1 || die

	# do the docs (maby add a use variable or put in seperate
	# ebuild since it is mostly developer docs?)
	if use doc ; then
		cd "${S}"/devel-docs
		emake || die
		cd "${S}"
	fi
}

src_install() {
	make prefix="${D}"/usr \
		libdir="${D}"/usr/$(get_libdir) \
		mandir="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		sysconfdir="${D}"/etc \
		localstatedir="${D}"/var/lib \
		docdir="${D}"/usr/share/doc/${PF} \
		HTML_DIR="${D}"/usr/share/gnome/html \
		install || die

	rm "${D}"/usr/share/gtkrc*

	dodoc AUTHORS ChangeLog README NEWS HACKING
}
