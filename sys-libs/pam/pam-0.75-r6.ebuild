# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.75-r6.ebuild,v 1.8 2002/08/14 05:09:59 murphy Exp $

S=${WORKDIR}/Linux-PAM-${PV}
S2=${WORKDIR}/pam
DESCRIPTION="Pluggable Authentication Modules"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-${PV}.tar.gz"
HOMEPAGE="http://www.redhat.com/linux-info/pam/"
LICENSE="PAM"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"

DEPEND=">=sys-libs/cracklib-2.7-r3
	=dev-libs/glib-1.2*
	>=sys-libs/pwdb-0.61-r3
	>=sys-devel/autoconf-2.13
	>=sys-devel/automake-1.4
	berkdb? ( ~sys-libs/db-1.85 )"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	tar -jxf ${FILESDIR}/pam-${PVR}-gentoo.tbz2 || die
	cd ${S}
	tar -jxf ${S2}/pam-redhat-0.75-21.tar.bz2 || die
	cp /usr/share/automake/install-sh . || die
	ln -sf defs/redhat.defs default.defs
	
	for x in `cat ${S2}/patch.list`
	do
		bzip2 -dc ${S2}/patchdir/${x} | patch -p1 || die
	done

	autoconf

	# for gcc3 compatibility
	cp configure configure_old
	sed -e "s:-lpwdb:-lpwdb -lcrypt -L/lib -L/usr/lib:" \
		configure_old > configure
	chmod 755 configure
}

src_compile() {
	./configure --prefix= \
		--host=${CHOST} \
		--sbindir=/usr/sbin \
		--mandir=/usr/share/man \
		--enable-fakeroot=${D} \
		--enable-static-libpam \
		--enable-read-both-confs || die
		
	cp Makefile Makefile.orig
	sed -e "s:libpam_misc doc examples:libpam_misc:" \
		Makefile.orig > Makefile
	cp Make.Rules Make.orig
	sed -e "s:/usr/bin/install:/bin/install:" \
		-e "s:-Wpointer-arith::" \
		-e "s:^CFLAGS=:CFLAGS=${CFLAGS} :" \
		Make.orig > Make.Rules
	# for gcc3 compatibility
	cp modules/pam_pwdb/Makefile modules/pam_pwdb/Makefile_orig
	sed -e "s:-lpwdb:-lpwdb -lcrypt -lnsl:g" \
		modules/pam_pwdb/Makefile_orig > modules/pam_pwdb/Makefile
		
	if [ -z "`use berkdb`" ]
	then
		cp Make.Rules Make.orig
		sed -e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" \
			Make.orig > Make.Rules
	fi
	
	make || die

	cd doc
	tar xvzf Linux-PAM-0.75-docs.tar.gz
}

src_install() {
	make MANDIR="/usr/share/man" \
		install || die

	#make sure every module built.
	#do not remove this, as some module can fail to build
	#and effectively lock the user out of his system.
	for x in modules/pam_*
	do
		if [ -d ${x} ]
		then
			if ! ls -1 ${D}/lib/security/`basename ${x}`*.so
			then
				if [ -z "`use berkdb`" ] && \
				   [ "`basename ${x}`" = "pam_userdb" ]
				then
					continue
				fi
				echo ERROR `basename ${x}` module did not build.
				exit 1
			fi
		fi
	done

	dodoc CHANGELOG Copyright README
	docinto modules
	dodoc modules/README
	
	cd modules
	for i in pam_*
	do
		if [ -f $i/README ]
		then
			docinto modules/$i
			dodoc $i/README
		fi
	done

	cd ..
	docinto html
	dohtml doc/html/*.html
	docinto txt
	dodoc doc/txts/*.txt doc/specs/*.txt
	docinto print
	dodoc doc/ps/*.ps


	cd ${D}/lib
	for i in pam pamc pam_misc
	do
		rm lib${i}.so
		ln -s lib${i}.so.${PV} lib${i}.so
		ln -s lib${i}.so.${PV} lib${i}.so.0
	done

	insinto /etc/pam.d
	cd ${FILESDIR}/${PVR}/pam.d
	doins *
}

