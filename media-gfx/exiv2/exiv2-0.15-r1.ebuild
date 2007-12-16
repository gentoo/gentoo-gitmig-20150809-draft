# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.15-r1.ebuild,v 1.1 2007/12/16 01:20:13 sbriesen Exp $

inherit eutils

DESCRIPTION="EXIF and IPTC metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"

IUSE="doc nls zlib unicode"
IUSE_LINGUAS="de es fi fr pl ru"

for X in ${IUSE_LINGUAS}; do IUSE="${IUSE} linguas_${X}"; done

RDEPEND="zlib? ( sys-libs/zlib )
	nls? ( virtual/libintl )
	virtual/libiconv"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# see bug #202351
	epatch "${FILESDIR}/CVE-2007-6353.diff"

	if use unicode; then
		for i in doc/cmd.txt; do
			echo ">>> Converting "${i}" to UTF-8"
			iconv -f LATIN1 -t UTF-8 "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi

	if use doc; then
		echo ">>> Updating doxygen config"
		doxygen &>/dev/null -u config/Doxyfile
	fi
}

src_compile() {
	local myconf="$(use_enable nls)"
	use zlib || myconf="${myconf} --without-zlib"  # plain 'use_with' fails
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README doc/{ChangeLog,cmd.txt}
	use doc && dohtml -r doc/html/.
}

pkg_postinst() {
	ewarn
	ewarn "PLEASE PLEASE take note of this:"
	ewarn "Please make *sure* to run revdep-rebuild now"
	ewarn "Certain things on your system may have linked against a"
	ewarn "different version of exiv2 -- those things need to be"
	ewarn "recompiled. Sorry for the inconvenience!"
	ewarn
}
