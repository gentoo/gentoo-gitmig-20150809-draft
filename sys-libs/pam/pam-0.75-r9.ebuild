# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.75-r9.ebuild,v 1.12 2004/01/26 01:12:29 vapier Exp $

IUSE="berkdb"

inherit gcc

PATCH_LEVEL=""

S="${WORKDIR}/Linux-PAM-${PV}"
S2="${WORKDIR}/pam"
DESCRIPTION="Pluggable Authentication Modules"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-${PV}.tar.gz
	mirror://gentoo/pam-${PVR}${PATCH_LEVEL}-gentoo.tbz2"
HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"

LICENSE="GPL-2 | BSD"
KEYWORDS="x86 ppc sparc alpha mips ia64"
SLOT="0"

DEPEND=">=sys-libs/cracklib-2.7-r3
	=dev-libs/glib-1.2*
	>=sys-libs/pwdb-0.61-r3
	>=sys-devel/autoconf-2.5
	>=sys-devel/automake-1.6
	>=sys-devel/flex-2.5.4a-r5
	berkdb? ( ~sys-libs/db-1.85
	          ~sys-libs/db-3.2.9 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	tar -jxf ${S2}/pam-redhat-0.75-41.1.tar.bz2 || \
		die "Failed to unpack pam-redhat-0.75-41.1.tar.bz2"

	cp /usr/share/automake/install-sh . || die
	ln -sf defs/redhat.defs default.defs

	einfo "Applying various patches (bugfixes/updates)..."
	for x in $(cat ${S2}/patch.list ${S2}/patch.list.gentoo)
	do
		if [ -f ${S2}/patchdir/${x} ]
		then
			einfo "  ${x##*/}..."
			bzip2 -dc ${S2}/patchdir/${x} | patch -p1 > /dev/null || \
				die "Failed Patch: ${x##*/}!"
		fi
	done

	for readme in modules/pam_*/README
	do
		cp -f ${readme} doc/txts/README.$(dirname ${readme} | sed -e 's|^modules/||')
	done

	export WANT_AUTOCONF=2.5
	autoconf

	cd ${S}/doc
	einfo "Unpacking docs..."
	tar -xvzf Linux-PAM-0.75-docs.tar.gz > /dev/null || \
		die "Failed to unpack docs"
}

src_compile() {
	export CFLAGS="${CFLAGS} -fPIC"

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

	make || die "Failed to build"
}

src_install() {
	make FAKEROOT=${D} \
		LDCONFIG="" \
		install || die

	# Make sure every module built.
	# Do not remove this, as some module can fail to build
	# and effectively lock the user out of his system.
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
		# Another snag in the problem with gcc3 linking static
		# libs in /usr/lib before dynamic ones in /lib (bug #4411).
		# Seems like c++ stuff do not link properly with libpam.so,
		# but rather with libpam.a, and as pam must be dynamic to
		# load its modules, it breaks auth for a few critical things
		# (like gdm and kdm).  This is not tested, but the urgency
		# demands a solution.
		# <azarah@gentoo.org> (24 Oct 2002)
		#mv lib${x}.a ${D}/usr/lib
		rm -f lib${x}.a
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

