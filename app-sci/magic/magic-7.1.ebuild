# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/magic/magic-7.1.ebuild,v 1.5 2002/07/25 16:18:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The VLSI design CAD tool"
SRC_URI="http://vlsi.cornell.edu/magic/magic-current.tar.gz"
HOMEPAGE="http://vlsi.cornell.edu/magic/"
KEYWORDS="x86"
LICENSE="as-is"
DEPEND=">=app-shells/tcsh-6.10-r3"
RDEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"
SLOT="7"

src_unpack() {
	unpack ${DISTFILES}/magic-current.tar.gz

	# Patch to use FHS paths
	patch -p1 < ${FILESDIR}/magic-7.1-fhs.patch 

	# Insert our idea of configuration file
	cp ${FILESDIR}/defs.mak-7.1 ${S}/defs.mak
}

src_compile() {
	if [ -n "`use readline`" ] ; then
		export READLINE_LIBS="-lreadline -lcurses"
		export READLINE_DEFS="-DUSE_READLINE -DHAVE_READLINE"
	fi

	emake || die

	[ -n "$READLINE_LIBS" ] && unset READLINE_LIBS
	[ -n "$READLINE_DEFS" ] && unset READLINE_DEFS
}

src_install () {
	make DESTDIR=${D} install || die

	insinto /etc/env.d
	doins ${FILESDIR}/10magic
}
