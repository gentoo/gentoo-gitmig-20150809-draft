# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/magic/magic-7.1-r1.ebuild,v 1.7 2003/09/06 22:23:06 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The VLSI design CAD tool"
SRC_URI="http://vlsi.cornell.edu/magic/${P}.tar.gz"
HOMEPAGE="http://vlsi.cornell.edu/magic/"
KEYWORDS="x86"
LICENSE="as-is"
DEPEND="sys-apps/findutils
	dev-lang/perl
	>=app-shells/tcsh-6.10-r3
	sys-libs/libtermcap-compat"
RDEPEND="sys-libs/libtermcap-compat"
SLOT="7"

src_unpack() {
	unpack ${A}

	# Patch to use FHS paths
	patch -p1 < ${FILESDIR}/${P}-fhs.patch

	# Patch for GCC 3.2 compatibility
	patch -p1 < ${FILESDIR}/${P}-gcc3.2.patch

	# Insert our idea of configuration file
	cp ${FILESDIR}/defs.mak-${PV}-r1 ${S}/defs.mak

	# Clean up all the pre-GCC-3.2 preprocessor directives
	einfo "Cleansing preprocessor directives"
	find ./ -name "*.[ch]" | xargs -n 1 perl -pi -e 's/^\#endif..*$/\#endif/'
	find ./ -name "*.[ch]" | xargs -n 1 perl -pi -e 's/^\#else..*$/\#else/'
}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	insinto /etc/env.d
	doins ${FILESDIR}/10magic
}
