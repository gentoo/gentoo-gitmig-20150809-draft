# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.20.0-r2.ebuild,v 1.6 2002/08/14 04:19:39 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://arcana.linux.it/pub/gpm/gpm-1.20.0.tar.bz2
	http://www.ibiblio.org/gentoo/distfiles/gpm-1.20.0-patch.tar.bz2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	sys-devel/autoconf"
	
RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	#this little hack turns off EMACS byte compilation.  Really don't want
	#this thing auto-detecting emacs
	patch -p1 < ${WORKDIR}/gpm.patch || die
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
