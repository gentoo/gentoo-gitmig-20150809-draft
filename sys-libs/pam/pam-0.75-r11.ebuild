# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.75-r11.ebuild,v 1.23 2004/01/30 07:30:01 drobbins Exp $

IUSE="berkdb selinux"

PATCH_LEVEL=""

SELINUX_PATCH="pam-0.75-selinux.diff.bz2"

S="${WORKDIR}/Linux-PAM-${PV}"
S2="${WORKDIR}/pam"
DESCRIPTION="Pluggable Authentication Modules"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-${PV}.tar.gz
	mirror://gentoo/pam-${PVR}${PATCH_LEVEL}-gentoo.tbz2"
HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"

LICENSE="BSD | GPL-2"
KEYWORDS="amd64 x86 ppc sparc alpha hppa arm mips"
SLOT="0"

RDEPEND=">=sys-libs/cracklib-2.7-r3
	=dev-libs/glib-1.2*
	>=sys-libs/pwdb-0.61-r4
	berkdb? ( >=sys-libs/db-3.2.9 )
	selinux? ( sys-libs/libselinux )"

DEPEND="$RDEPEND
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.6
	>=sys-devel/flex-2.5.4a-r5"

#inherit needs to be after DEPEND definition to protect RDEPEND
inherit gcc eutils flag-o-matic

src_unpack() {
	unpack ${A}

	cd ${S}
	tar -jxf ${S2}/pam-redhat-0.75-41.1.tar.bz2 || \
		die "Failed to unpack pam-redhat-0.75-41.1.tar.bz2"

	cp /usr/share/automake/install-sh . || die
	ln -sf defs/redhat.defs default.defs

	for x in $(cat ${S2}/patch.list ${S2}/patch.list.gentoo)
	do
		if [ -f ${S2}/patchdir/${x} ]
		then
			epatch ${S2}/patchdir/${x}
		fi
	done

	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}

	cd ${S}/doc
	einfo "Unpacking docs..."
	tar -xvzf Linux-PAM-0.75-docs.tar.gz > /dev/null || \
		die "Failed to unpack docs!"

	cd ${S}; einfo "Installing module docs..."
	for readme in modules/pam_*/README
	do
		cp -f ${readme} doc/txts/README.$(dirname ${readme} | sed -e 's|^modules/||')
	done

	epatch ${FILESDIR}/pam-0.75-configure-db4.patch

	einfo "Generating configure..."
	export WANT_AUTOCONF=2.5
	cd ${S}; autoconf || :
}

src_compile() {
	export CFLAGS="${CFLAGS} -fPIC"
	if [ "${ARCH}" = "alpha" ]; then
		if [ ! -z "`strings -a /usr/lib/libglib.a | grep -i 'Compaq Computer Corp.'`" ] ; then
			# should be LDFLAGS, but this configure is screwy.
			einfo "It looks like you compiled glib with ccc, this is okay, but"
			einfo "I'll need to force gcc to link with libots...."
			append-flags -lots
			cp ${S}/modules/pam_pwdb/Makefile ${S}/modules/pam_pwdb/Makefile.orig
			sed -e 's/$(CC) -o/$(CC) -lots -o/g' ${S}/modules/pam_pwdb/Makefile.orig > \
				${S}/modules/pam_pwdb/Makefile
		fi
	fi

	./configure --host=${CHOST} \
		--prefix=/ \
		--sbindir=/usr/sbin \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--enable-securedir=/lib/security \
		--enable-fakeroot=${D} \
		--enable-static-libpam \
		|| die "Failed to configure"

	# Python stuff in docs gives sandbox problems
	cp Makefile Makefile.orig
	sed -e "s:libpam_misc doc examples:libpam_misc:" \
		Makefile.orig > Makefile

	# Fix warnings for gcc-2.95.3
	if [ "$(gcc-version)" = "2.95" ]
	then
		cp Make.Rules Make.Rules.orig
		sed -e "s:-Wpointer-arith::" \
			Make.Rules.orig > Make.Rules
		rm -f Make.Rules.orig
	fi

	if [ -z "$(use berkdb)" ]
	then
		cp Make.Rules Make.Rules.orig
		sed -e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" \
			Make.Rules.orig > Make.Rules
		rm -f Make.Rules.orig
	fi

	# work/Linux-PAM-0.75/modules/pam_pwdb/Makefile:    $(CC) -o $(CHKPWD) $^ -lpwdb
	has_version "sys-devel/hardened-gcc" && \
		sed -i "s:-lpwdb:-lpwdb -lcrypt:g" ${WORKDIR}/Linux-PAM-0.75/modules/pam_pwdb/Makefile

	make || die "Failed to build"
}

src_install() {
	make FAKEROOT=${D} \
		LDCONFIG="" \
		install || die

	# Make sure every module built.
	# Do not remove this, as some module can fail to build
	# and effectively lock the user out of his system.
	einfo "Checking if all modules were built..."
	for x in ${S}/modules/pam_*
	do
		if [ -d ${x} ]
		then
			if ! ls -1 ${D}/lib/security/$(basename ${x})*.so &> /dev/null
			then
				if [ -z "$(use berkdb)" -a "$(basename ${x})" = "pam_userdb" ]
				then
					continue
				fi
				eerror "ERROR: $(basename ${x}) module did not build."
				exit 1
			fi
		fi
	done

	cd ${S}
	dodoc CHANGELOG Copyright README
	docinto modules
	dodoc modules/README
	dodoc doc/txts/README.*
	docinto txt
	dodoc doc/txts/*.txt doc/specs/*.txt
	docinto print
	dodoc doc/ps/*.ps

	doman doc/man/*.[38]

	docinto html
	dohtml -r doc/html/

	dodir /usr/lib
	cd ${D}/lib
	for x in pam pamc pam_misc
	do
		rm lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so.0
		mv lib${x}.a ${D}/usr/lib
		# See bug #4411
		gen_usr_ldscript lib${x}.so
	done

	# need this for pam_console
	keepdir /var/run/console

	insinto /etc/pam.d
	for x in ${FILESDIR}/${PVR}/pam.d/*
	do
		if [ -f ${x} ]
		then
			doins ${x}
		fi
	done
}

