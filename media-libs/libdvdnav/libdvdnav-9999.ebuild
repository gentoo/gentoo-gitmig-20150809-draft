# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-9999.ebuild,v 1.1 2009/03/09 18:04:48 beandog Exp $

WANT_AUTOCONF="2.5"

inherit eutils autotools multilib subversion

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://mplayerhq.hu/ http://svn.mplayerhq.hu/dvdnav/trunk/libdvdnav/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

ESVN_REPO_URI="svn://svn.mplayerhq.hu/dvdnav/trunk/libdvdnav"
ESVN_PROJECT="libdvdnav"

src_compile() {
	./configure2 --prefix=/usr --libdir=/usr/$(get_libdir) \
		--shlibdir=/usr/$(get_libdir) --enable-static --enable-shared \
		--disable-strip --disable-opts $(use_enable debug) \
		--extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" \
	emake version.h && emake || die "emake version.h died"
	emake || die "emake died"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install died"
	dodoc AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO \
		doc/dvd_structures README
}
