# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/clearsilver/clearsilver-0.10.5-r1.ebuild,v 1.3 2011/03/25 20:00:39 xarthisius Exp $

# Please note: apache, java, mono and ruby support disabled for now.
# Fill a bug if you need it.
#
# dju@gentoo.org, 4th July 2005

inherit eutils perl-app multilib autotools

DESCRIPTION="Clearsilver is a fast, powerful, and language-neutral HTML template system."
HOMEPAGE="http://www.clearsilver.net/"
SRC_URI="http://www.clearsilver.net/downloads/${P}.tar.gz"

LICENSE="CS-1.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="perl python zlib"

DEPEND="python? ( dev-lang/python )
	perl? ( dev-lang/perl )
	zlib? ( sys-libs/zlib )"

DOCS="README INSTALL"

if use python ; then
	DOCS="${DOCS} README.python"
fi

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-perl_installdir.patch

	use zlib && epatch "${FILESDIR}"/${P}-libz.patch

	epatch "${FILESDIR}"/${P}-libdir.patch
	sed -i -e "s:GENTOO_LIBDIR:$(get_libdir):" configure.in
	eautoreconf || die "eautoreconf failed"

	# Fix for Gentoo/Freebsd
	[[ "${ARCH}" == FreeBSD ]] && touch ${S}/features.h ${S}/cgi/features.h
}

src_compile() {
	econf \
		$(use_enable perl) \
		$(use_with perl perl /usr/bin/perl) \
		$(use_enable python) \
		$(use_with python python /usr/bin/python) \
		$(use_enable zlib compression) \
		"--disable-apache" \
		"--disable-ruby" \
		"--disable-java" \
		"--disable-csharp" \
		|| die "./configure failed"

	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc ${DOCS} || die "dodoc failed"

	if use perl ; then
		fixlocalpod || die "fixlocalpod failed"
	fi
}
