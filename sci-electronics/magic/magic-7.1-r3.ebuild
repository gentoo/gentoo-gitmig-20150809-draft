# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/magic/magic-7.1-r3.ebuild,v 1.3 2005/06/27 02:18:41 ribosome Exp $

inherit eutils flag-o-matic

DESCRIPTION="The VLSI design CAD tool"
HOMEPAGE="http://vlsi.cornell.edu/magic/"
SRC_URI="http://vlsi.cornell.edu/magic/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="sys-apps/findutils
	dev-lang/perl
	>=app-shells/tcsh-6.10-r3
	sys-libs/libtermcap-compat"
RDEPEND="sys-libs/libtermcap-compat
	!sys-apps/file"

src_unpack() {
	unpack ${A}

	# Patch to use FHS paths
	epatch ${FILESDIR}/${P}-fhs.patch

	# Patch for GCC 3.2 compatibility
	epatch ${FILESDIR}/${P}-gcc3.2.patch

	# Add one more needed for GCC 3.4 (but earlier gcc won't mind)
	epatch ${FILESDIR}/${P}-remove-decl.patch

	# Fix endianness problem for ppc
	epatch ${FILESDIR}/${P}-ppc-endian.patch

	# some gcc 3.3 stuff, paths...
	cd ${S}
	# work around cvs problem
	sed -i 's/\$Header/\$NO_RCS_Header/' magic/proto.magic
	epatch ${FILESDIR}/${P}-misc.patch

	# Insert our idea of configuration file
	cp ${FILESDIR}/defs.mak-${PV}-r2 ${S}/defs.mak
	strip-flags
	sed -i  "/^CFLAGS/ s/=.*/= ${CFLAGS}/;" ${S}/defs.mak

	scripts/makedbh database/database.h.in database/database.h

	# Clean up all the pre-GCC-3.2 preprocessor directives
	einfo "Cleansing preprocessor directives"
	find ./ -name "*.[ch]" | xargs -n 1 perl -pi -e 's/^\#endif..*$/\#endif/'
	find ./ -name "*.[ch]" | xargs -n 1 perl -pi -e 's/^\#else..*$/\#else/'
}

src_compile() {
	# this program does not like optimizations or parallel builds
	make || die
	egrep -q "^make.*Error" make.log && die "Error while compiling - please add ${S}/make.log to your error report."
}

src_install() {
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
	ln -s ../../share/magic/sys magic/sys
	ln -s ../../share/magic/scm magic/scm
	ln -s ../../share/magic/tutorial magic/tutorial

	# try to make man page names unique (many are so generic they collide)
	cd ${D}/usr/share/man
	find . -type f ! -name "*magic*" -exec \
		sh -c 'F=`echo {} | sed -e "s:\(man.\)/:\1/magic-:;"` ; mv "{}" "${F}" ' \;
}
