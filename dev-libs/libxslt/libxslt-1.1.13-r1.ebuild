# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.1.13-r1.ebuild,v 1.2 2005/03/26 15:27:38 kugelfang Exp $

inherit libtool gnome.org eutils python

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="python crypt"

DEPEND=">=dev-libs/libxml2-2.6.17
	crypt? ( >=dev-libs/libgcrypt-1.1.92 )
	python? ( dev-lang/python )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# we still require the 1.1.8 patch for the .m4 file, to add
	# the CXXFLAGS defines <obz@gentoo.org>
	epatch ${FILESDIR}/libxslt.m4-${PN}-1.1.8.patch

	# patch for xslt missing dictionary, see:
	# http://bugs.gentoo.org/show_bug.cgi?id=86327 and
	# http://bugzilla.gnome.org/show_bug.cgi?id=170533
	# <obz@gentoo.org>
	epatch ${FILESDIR}/${P}-xslt.patch

	elibtoolize
}

src_compile() {
	econf \
		$(use_with python) \
		$(use_with crypt crypto) \
		|| die "configure failed"

	# Patching the Makefiles to respect get_libdir
	# Fixes BUG #86756, please keep this.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && for x in $(find ${S} -name "Makefile") ; do
		sed \
			-e "s|^\(PYTHON_SITE_PACKAGES\ =\ \/usr\/\).*\(\/python.*\)|\1$(get_libdir)\2|g" \
			-i ${x} \
			|| die "sed failed"
	done

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README NEWS TODO
}
