# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.75-r7.ebuild,v 1.17 2004/01/30 07:30:01 drobbins Exp $

IUSE="berkdb"

S=${WORKDIR}/Linux-PAM-${PV}
S2=${WORKDIR}/pam
DESCRIPTION="Pluggable Authentication Modules"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-${PV}.tar.gz"
HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"

LICENSE="GPL-2 | BSD"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"

RDEPEND=">=sys-libs/cracklib-2.7-r3
	=dev-libs/glib-1.2*
	>=sys-libs/pwdb-0.61-r3
	berkdb? ( ~sys-libs/db-1.85 ~sys-libs/db-3.2.9 )"

DEPEND="$RDEPEND
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.6
	>=sys-devel/flex-2.5.4a-r5"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	tar -jxf ${FILESDIR}/pam-${PVR}-gentoo.tbz2 || \
		die "Failed to unpack patches"

	cd ${S}
	tar -jxf ${S2}/pam-redhat-0.75-21.tar.bz2 || \
		die "Failed to unpack pam-redhat-0.75-21.tar.bz2"

	cp /usr/share/automake/install-sh . || die
	ln -sf defs/redhat.defs default.defs

	for x in `cat ${S2}/patch.list`
	do
		bzip2 -dc ${S2}/patchdir/${x} | patch -p1 || \
			die "Failed to apply ${x}"
	done

	# Fixes a segfault in module pam_wheel.so when "use_uid" is not
	# used as argument to module.  This should resolve bug #5686.
	#
	# Martin Schlemmer <azarah@gentoo.org> (31 Jul 2002)
	patch -p1 < ${FILESDIR}/${P}-pam_wheel-segfault.patch || die

	# Fixes the config file location of pam_group.so.  This
	# resolves bug #6010.
	#
	# Martin Schlemmer <azarah@gentoo.org> (05 Aug 2002)
	patch -p1 < ${FILESDIR}/${P}-pam_group-confile.patch || die

	export WANT_AUTOCONF=2.5
	autoconf

	# For some reason do not link to libcrypt.
	cp configure configure_old
	sed -e "s:-lpwdb:-lpwdb -lcrypt -L/lib -L/usr/lib:" \
		configure_old > configure
	chmod 0755 configure
}

src_compile() {
	export CFLAGS="${CFLAGS} -fPIC"

	./configure --prefix= \
		--host=${CHOST} \
		--sbindir=/usr/sbin \
		--mandir=/usr/share/man \
		--enable-fakeroot=${D} \
		--enable-static-libpam \
		|| die "Failed to configure"

	# Python stuff in docs gives sandbox problems
	cp Makefile Makefile.orig
	sed -e "s:libpam_misc doc examples:libpam_misc:" \
		Makefile.orig > Makefile
	cp Make.Rules Make.orig

	# Fix warnings for gcc-2.95.3
	[ -z "${CC}" ] && CC=gcc
	if [ "`${CC} -dumpversion`" = "2.95.3" ]
	then
		sed -e "s:/usr/bin/install:/bin/install:" \
			-e "s:-Wpointer-arith::" \
			Make.orig > Make.Rules
	else
		sed -e "s:/usr/bin/install:/bin/install:" \
			Make.orig > Make.Rules
	fi

	# For some reason do not link to libcrypt
	cp modules/pam_pwdb/Makefile modules/pam_pwdb/Makefile_orig
	sed -e "s:-lpwdb:-lpwdb -lcrypt -lnsl:g" \
		modules/pam_pwdb/Makefile_orig > modules/pam_pwdb/Makefile

	if [ -z "`use berkdb`" ]
	then
		cp Make.Rules Make.orig
		sed -e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" \
			Make.orig > Make.Rules
	fi

	make || die "Failed to build"

	cd ${S}/doc
	tar -xvzf Linux-PAM-0.75-docs.tar.gz || die "Failed to unpack docs"
}

src_install() {
	make FAKEROOT=${D} \
		MANDIR="/usr/share/man" \
		LDCONFIG="" \
		install || die

	#make sure every module built.
	#do not remove this, as some module can fail to build
	#and effectively lock the user out of his system.
	for x in ${S}/modules/pam_*
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
				eerror "ERROR: `basename ${x}` module did not build."
				exit 1
			fi
		fi
	done

	dodoc CHANGELOG Copyright README
	docinto modules
	dodoc modules/README

	cd ${S}/modules
	for x in pam_*
	do
		if [ -f ${x}/README ]
		then
			docinto modules/${x}
			dodoc ${x}/README
		fi
	done

	cd ${S}
	docinto html
	dohtml doc/html/*.html
	docinto txt
	dodoc doc/txts/*.txt doc/specs/*.txt
	docinto print
	dodoc doc/ps/*.ps


	cd ${D}/lib
	for x in pam pamc pam_misc
	do
		rm lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so.0
	done

	insinto /etc/pam.d
	cd ${FILESDIR}/${PVR}/pam.d
	doins *
}

