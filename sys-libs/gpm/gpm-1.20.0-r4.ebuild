# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.20.0-r4.ebuild,v 1.5 2003/06/21 22:06:04 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://arcana.linux.it/pub/gpm/gpm-1.20.0.tar.bz2
	http://www.ibiblio.org/gentoo/distfiles/gpm-1.20.1-patch.tar.bz2"
HOMEPAGE="ftp://arcana.linux.it/pub/gpm/"

DEPEND=">=sys-libs/ncurses-5.2
	sys-devel/autoconf"
	
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

src_compile() {
	#this little hack turns off EMACS byte compilation.  Really don't want
	#this thing auto-detecting emacs
	patch -p1 < ${WORKDIR}/gpm.patch || die
	econf --sysconfdir=/etc/gpm || die

	# Do not create gpmdoc.ps, as it cause build to fail with our version
	# of tetex (it is already there, so this will only create missing
	# manpages)
	cp doc/Makefile doc/Makefile.orig
	sed -e 's:all\: $(srcdir)/gpmdoc.ps:all\::' \
		doc/Makefile.orig > doc/Makefile

	MAKEOPTS="-j1" emake || die
}

src_install() {
	if [ ! -e ${S}/mkinstalldirs ]
	then
		#create missing script
		echo 'mkdir -p "$@"' > ${S}/mkinstalldirs
		chmod u+x ${S}/mkinstalldirs
	fi
	einstall
	chmod 755 ${D}/usr/lib/*
	dodoc BUGS COPYING ChangeLog Changes MANIFEST README TODO
	dodoc doc/Announce doc/FAQ doc/README*
	doinfo doc/gpm.info

	insinto /etc/gpm
	doins conf/gpm-*.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/gpm.rc6 gpm
	insinto /etc/conf.d
	newins ${FILESDIR}/gpm.conf.d gpm
}
