# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/magic/magic-7.1-r2.ebuild,v 1.2 2003/11/17 17:51:47 phosphan Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The VLSI design CAD tool"
SRC_URI="http://vlsi.cornell.edu/magic/${P}.tar.gz"
HOMEPAGE="http://vlsi.cornell.edu/magic/"
KEYWORDS="~x86"
LICENSE="as-is"
DEPEND="sys-apps/findutils
	dev-lang/perl
	>=app-shells/tcsh-6.10-r3
	sys-libs/libtermcap-compat"
RDEPEND="sys-libs/libtermcap-compat"
SLOT="7"

inherit eutils

src_unpack() {
	unpack ${A}

	# Patch to use FHS paths
	epatch ${FILESDIR}/${P}-fhs.patch

	# Patch for GCC 3.2 compatibility
	epatch ${FILESDIR}/${P}-gcc3.2.patch

	# deprecated varargs stuff
	cd ${S}
	epatch ${FILESDIR}/${P}-vararg.patch

	# modify hardcoded paths
	epatch ${FILESDIR}/${P}-paths.patch

	# Insert our idea of configuration file
	cp ${FILESDIR}/defs.mak-${PV}-r2 ${S}/defs.mak

	scripts/makedbh database/database.h.in database/database.h

	# Clean up all the pre-GCC-3.2 preprocessor directives
	einfo "Cleansing preprocessor directives"
	find ./ -name "*.[ch]" -or -name "proto.magic" | xargs -n 1 perl -pi -e 's/^\#endif..*$/\#endif/'
	find ./ -name "*.[ch]" -or -name "proto.magic" | xargs -n 1 perl -pi -e 's/^\#else..*$/\#else/'
}

src_compile() {
	# this program does not like optimizations or parallel builds
	make || die
	egrep -q "^make.*Error" make.log && die "Error while compiling - please add ${S}/make.log to your error report."
}

src_install () {
	make DESTDIR=${D} install || die

	insinto /etc/env.d
	doins ${FILESDIR}/10magic
	keepdir /var/lock/magic
	chmod +t ${D}/var/lock/magic
	chmod ugo+rwx ${D}/var/lock/magic
	cd ${D}/usr/lib/magic
	mv * ${D}/usr/share/magic/
	cd ${D}/usr/lib
	mv *.h *.a magic/
	dosym ../share/magic/sys magic/sy
	dosym ../share/magic/scm magic/scm
}
