# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.3.14-r1.ebuild,v 1.21 2007/06/26 01:34:07 mr_bones_ Exp $

inherit eutils autotools

DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
HOMEPAGE="http://www.gnupg.org/gpgme.html"
SRC_URI="mirror://gnupg/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0.3"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc"
# smime once post gnupg-1.9+ gets unmasked

DEPEND=">=sys-libs/zlib-1.1.3
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	sys-devel/autoconf
	=sys-devel/automake-1.6*
	>=sys-apps/sed-4
	>=app-crypt/gnupg-1.2.0"

#For gnupg-1.9+ gets unmasked
#       !smime? ( >=app-crypt/gnupg-1.2.5 )
#       smime? ( >=app-crypt/gnupg-1.9.10 )

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gpgme3.m4.patch
	find . -name Makefile -o -name Makefile.in -exec rm {} \;
	rm doc/gpgme.info-?

	sed -i -e 's:libgpgme:libgpgme3:g' \
		`find . -name Makefile.am` doc/gpgme.info

	sed -i -e 's:gpgme-config:gpgme3-config:g' \
		configure.ac gpgme/Makefile.am doc/gpgme.texi \
		gpgme/gpgme-config.in

	sed -i -e 's:gpgme\.info:gpgme3.info:g' \
		-e 's:gpgme\.texi:gpgme3\.texi:g' \
		doc/Makefile.am doc/gpgme.info

	sed -i -e 's:-lgpgme:-lgpgme3:g' \
		gpgme/gpgme-config.in \
		doc/gpgme.texi configure.ac

	sed -i -e 's:gpgme\.m4:gpgme3.m4:g' \
		gpgme/Makefile.am configure.ac doc/gpgme.texi \
		gpgme/mkerrors \
		`find . -name \*.c -o -name \*.h`

	sed -i -e 's:gpgme\.info:gpgme3.info:' doc/gpgme.texi

	mv doc/gpgme{,3}.texi
	mv gpgme/gpgme{,3}-config.in
	mv gpgme/gpgme{,3}.m4
	# mv gpgme/gpgme{,3}.h
	export WANT_AUTOMAKE="1.6"
	eautoreconf
}


src_compile() {
	local myconf

	use doc \
		&& myconf="${myconf} --enable-maintainer-mode"

	if [ -x ""/usr/bin/gpg2 ]; then
		myconf="${myconf} --with-gpg=/usr/bin/gpg2"
	else
		myconf="${myconf} --with-gpg=/usr/bin/gpg"
	fi

	# For gnugpg-1.9+
	# 		$(use_with smime gpgsm /usr/bin/gpgsm)
	#

	econf \
		--enable-gpgmeplug \
		--includedir=/usr/include/gpgme3 \
		${myconf} \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-alpha THANKS TODO VERSION
}
