# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.19.6.ebuild,v 1.12 2003/06/22 05:10:31 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://arcana.linux.it/pub/gpm/${P}.tar.bz2"
HOMEPAGE="ftp://arcana.linux.it/pub/gpm/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	sys-devel/autoconf"
	
RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {
	#this little hack turns off EMACS byte compilation.  Really don't want
	#this thing auto-detecting emacs
	env ac_cv_path_emacs=no \
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc/gpm || die

	# Do not create gpmdoc.ps, as it cause build to fail with our version
	# of tetex (it is already there, so this will only create missing
	# manpages)
	cp doc/Makefile doc/Makefile.orig
	sed -e 's:all\: $(srcdir)/gpmdoc.ps:all\::' \
		doc/Makefile.orig > doc/Makefile

	emake || die
}

src_install() {
	if [ ! -e ${S}/mkinstalldirs ]
	then
		#create missing script
		echo 'mkdir -p "$@"' > ${S}/mkinstalldirs
		chmod u+x ${S}/mkinstalldirs
	fi
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc/gpm \
		install || die
		
	chmod 755 ${D}/usr/lib/libgpm.so.*
	
	dodoc BUGS COPYING ChangeLog Changes MANIFEST README TODO
	dodoc doc/Announce doc/FAQ doc/README*
#	doman doc/gpm.8 doc/mev.1 doc/gpm-root.1 doc/gpm-types.7 doc/mouse-test.1
	doinfo doc/gpm.info
#	docinto txt
#	dodoc doc/gpmdoc.txt
#	docinto ps
#	dodoc doc/gpmdoc.ps

	insinto /etc/gpm
	doins conf/gpm-*.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/gpm.rc6 gpm
	insinto /etc/conf.d
	newins ${FILESDIR}/gpm.conf.d gpm
}

pkg_preinst() {
	# Gives problems (was linked to wrong lib for me)
	if [ -f /usr/lib/libgpm.so.1 ]
	then
		rm -f /usr/lib/libgpm.so.1
	fi
}

