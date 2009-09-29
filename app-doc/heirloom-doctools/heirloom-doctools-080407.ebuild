# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/heirloom-doctools/heirloom-doctools-080407.ebuild,v 1.1 2009/09/29 10:45:23 flameeyes Exp $

EAPI=2

inherit flag-o-matic toolchain-funcs multilib

DESCRIPTION="Classic Unix documentation tools ported from OpenSolaris"
HOMEPAGE="http://heirloom.sourceforge.net/doctools.html"
SRC_URI="mirror://sourceforge/heirloom/${P}.tar.bz2"

LICENSE="CDDL"

SLOT="0"

KEYWORDS="~amd64"

IUSE="cxx"

RDEPEND="!sys-apps/groff"
DEPEND="sys-devel/flex
	sys-devel/bison"

src_prepare() {
	# Make sure that C++ code is built with CXXFLAGS and not CFLAGS.
	find . -name Makefile.mk -exec \
		sed -i \
			-e '/(CCC)/s:CFLAGS:CXXFLAGS:' \
		{} +

	# mpm uses C++, we'll build it explicitly if we really want to
	sed -i -e 's:mpm:$(MPM):' makefile

	# Monkeypatching dependencies to avoid parallel make failure
	echo "picl.o: picl.c y.tab.h" >> pic/Makefile.mk
}

src_configure() {
	append-cppflags -D_GNU_SOURCE

	sed \
		-e "s:@CFLAGS@:${CFLAGS}:" \
		-e "s:@CXXFLAGS@:${CXXFLAGS}:" \
		-e "s:@CPPFLAGS@:${CPPFLAGS}:" \
		-e "s:@LDFLAGS@:${LDFLAGS}:" \
		-e "s:@CC@:$(tc-getCC):" \
		-e "s:@CXX@:$(tc-getCXX):" \
		-e "s:@RANLIB@:$(tc-getRANLIB):" \
		-e "s:@libdir@:$(get_libdir):" \
		"${FILESDIR}"/${PV}.config \
		> "${S}"/mk.config
}

src_compile() {
	emake $(use cxx && echo MPM=mpm) || die
}

src_install() {
	# The build system uses the ROOT variable in place of DESTIDR.
	emake $(use cxx && echo MPM=mpm) ROOT="${D}" install || die

	dodoc README CHANGES || die

	# Rename ptx to avoid a collision with coreutils… maybe this
	# should be made conditional to userland_GNU (somebody got to
	# check on FreeBSD).
	mv "${D}"/usr/bin/{,hl-}ptx || die
	mv "${D}"/usr/share/man/man1/{,hl-}ptx.1* || die

	# Not sure why they install in man1b, but we don't list that in by
	# default, so move all of them to man1. We don't do that in the
	# Makefiles, because it's definitely more complex (even though
	# faster).
	pushd "${D}"/usr/share/man
	for man in man1b/*.1b*; do
		mv $man ${man//1b/1} || die "failed moving $man"
	done
	rmdir man1b
	popd
}

pkg_postinst() {
	elog "To make proper use of heirloom-doctools with sys-apps/man you"
	elog "need to make sure that /etc/man.conf is configured properly with"
	elog "the following settings:"
	elog ""
	elog "TROFF           /usr/bin/troff -Tlocale -mg -msafe -mpadj -mandoc"
	elog "NROFF           /usr/bin/nroff -mg -msafe -mpadj -mandoc"
	elog "EQN             /usr/bin/eqn -Tps"
	elog "NEQN            /usr/bin/neqn -Tlatin1"
	elog "TBL             /usr/bin/tbl"
	elog "COL             /usr/bin/col"
	elog "REFER           /usr/bin/refer"
	elog "PIC             /usr/bin/pic"
	elog "VGRIND          /usr/bin/vgrind"
	elog "GRAP            /usr/bin/grap"
}
