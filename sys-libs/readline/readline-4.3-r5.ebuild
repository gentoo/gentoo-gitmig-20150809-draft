# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.3-r5.ebuild,v 1.20 2004/11/12 14:51:44 vapier Exp $

inherit eutils gnuconfig

# Official patches
PLEVEL="x001 x002 x003 x004 x005"

DESCRIPTION="Another cute console display library"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"
SRC_URI="mirror://gnu/readline/${P}.tar.gz
	${PLEVEL//x/mirror://gnu/${PN}/${PN}-${PV}-patches/${PN}${PV/\.}-}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

# We must be certain that we have a bash that is linked
# to its internal readline, else we may get problems.
DEPEND=">=app-shells/bash-2.05b-r2
	>=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	for x in ${PLEVEL//x}
	do
		epatch ${DISTDIR}/${PN}${PV/\.}-${x}
	done

	gnuconfig_update
}

src_compile() {
	# the --libdir= is needed because if lib64 is a directory, it will default
	# to using that... even if CONF_LIBDIR isnt set or we're using a version
	# of portage without CONF_LIBDIR support.
	econf --with-curses --libdir=/usr/$(get_libdir) || die

	emake || die
	cd shlib
	emake || die
}


src_install() {
	# portage 2.0.50's einstall causes sandbox violations if lib64 is a
	# directory, since readline's configure automatically sets libdir for you.
	make DESTDIR="${D}" install || die
	cd ${S}/shlib
	make DESTDIR="${D}" install || die

	cd ${S}

	dodir /$(get_libdir)
	mv ${D}/usr/$(get_libdir)/*.so* ${D}/$(get_libdir)
	rm -f ${D}/$(get_libdir)/*.old
	# bug #4411
	gen_usr_ldscript libreadline.so
	gen_usr_ldscript libhistory.so
	# end bug #4411
	dosym libhistory.so.${PV/a/} /$(get_libdir)/libhistory.so
	dosym libreadline.so.${PV/a/} /$(get_libdir)/libreadline.so
	# Needed because make install uses ${D} for the link
	dosym libhistory.so.${PV/a/} /$(get_libdir)/libhistory.so.4
	dosym libreadline.so.${PV/a/} /$(get_libdir)/libreadline.so.4
	chmod 755 ${D}/$(get_libdir)/*.${PV/a/}

	dodoc CHANGELOG CHANGES README USAGE
	docinto ps
	dodoc doc/*.ps
	dohtml -r doc

	# Backwards compatibility #29865
	if [ -e ${ROOT}/lib/libreadline.so.4.1 ] ; then
		[ "$(get_libdir)" != "lib" ] && dodir /lib
		cp -a ${ROOT}/lib/libreadline.so.4.1 ${D}/lib/
		touch ${D}/lib/libreadline.so.4.1
	fi
}

pkg_postinst() {
	if [ -e ${ROOT}/lib/libreadline.so.4.1 ] ; then
		ewarn "Your old readline libraries have been copied over."
		ewarn "You should run 'revdep-rebuild --soname libreadline.so.4.1' asap."
		ewarn "Once you have, you can safely delete /lib/libreadline.so.4.1"
	fi
}
