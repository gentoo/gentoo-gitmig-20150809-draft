# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.3.ebuild,v 1.6 2003/02/15 20:19:52 tuxus Exp $

IUSE="nls build"

S="${WORKDIR}/${P}"
DESCRIPTION="The GNU info program and utilities"
SRC_URI="mirror://gnu/texinfo/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/texinfo/"

KEYWORDS="x86 ppc sparc alpha mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc 
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"
RDEPEND="virtual/glibc 
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

src_unpack() {
	unpack ${A}

	cd ${S}/doc
	# Get the texinfo info page to have a proper name of texinfo.info
	cp texinfo.txi texinfo.txi.orig
	sed -e 's:setfilename texinfo:setfilename texinfo.info:' \
		texinfo.txi.orig > texinfo.txi
	cp Makefile.in Makefile.in.orig
	sed -e 's:INFO_DEPS = texinfo:INFO_DEPS = texinfo.info:' \
		-e 's:texinfo\::texinfo.info\::' \
		Makefile.in.orig > Makefile.in
}

src_compile() {
	local myconf=""
	if [ -z "`use nls`" ] || [ -n "`use build`" ] ; then
		myconf="--disable-nls"
	fi

	export WANT_AUTOMAKE_1_6=1
	econf ${myconf} || die
	
	emake || die 
}

src_install() {
	if [ "`use build`" ] ; then
		dobin makeinfo/makeinfo util/{install-info,texi2dvi,texindex}
	else
		make DESTDIR=${D} \
			infodir=/usr/share/info \
			install || die
			
		exeinto /usr/sbin
		doexe ${FILESDIR}/mkinfodir

		if [ ! -f ${D}/usr/share/info/texinfo.info ] ; then
			die "Could not install texinfo.info!!!"
		fi

		dodoc AUTHORS ChangeLog COPYING INTRODUCTION NEWS README TODO 
		docinto info
		dodoc info/README
		docinto makeinfo
		dodoc makeinfo/README
	fi
}

