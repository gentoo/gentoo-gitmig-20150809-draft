# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.4-r3.ebuild,v 1.1 2005/03/19 17:51:20 pythonhead Exp $

# NOTE about python-portage interactions :
# - Do not add a pkg_setup() check for a certain version of portage
#   in dev-lang/python. It _WILL_ stop people installing from
#   Gentoo 1.4 images.

inherit eutils flag-o-matic python multilib

PYVER_MAJOR="`echo ${PV%_*} | cut -d '.' -f 1`"
PYVER_MINOR="`echo ${PV%_*} | cut -d '.' -f 2`"
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
MY_P="Python-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PYVER}/${MY_P}.tar.bz2"
HOMEPAGE="http://www.python.org"

IUSE="ncurses gdbm ssl readline tcltk berkdb bootstrap ipv6 build ucs2 doc X"
LICENSE="PSF-2.2"
SLOT="2.4"

KEYWORDS="~x86 ~ppc ~sparc ~arm ~hppa ~amd64 ~s390 ~alpha ~ia64 ~mips"

DEPEND="virtual/libc
	>=sys-libs/zlib-1.1.3
	!build? (
		X? ( tcltk? ( >=dev-lang/tk-8.0 ) )
		ncurses? ( >=sys-libs/ncurses-5.2 readline? ( >=sys-libs/readline-4.1 ) )
		berkdb? ( >=sys-libs/db-3.1 )
		gdbm? ( sys-libs/gdbm )
		ssl? ( dev-libs/openssl )
		doc? ( =dev-python/python-docs-${PV}* )
		dev-libs/expat
	)"

RDEPEND="${DEPEND} dev-python/python-fchksum"

# The dev-python/python-fchksum RDEPEND is needed to that this python provides
# the functionality expected from previous pythons.

PROVIDE="virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Fixes security vulnerability in XML-RPC server - pythonhead (06 Feb 05)
	#http://www.python.org/security/PSF-2005-001/
	epatch ${FILESDIR}/${PN}-2.4-xmlrpc.patch
	# adds support for PYTHON_DONTCOMPILE shell environment to
	# supress automatic generation of .pyc and .pyo files - liquidx (08 Oct 03)
	epatch ${FILESDIR}/${PN}-${PYVER}-gentoo_py_dontcompile.patch
	epatch ${FILESDIR}/${PN}-${PYVER}-disable_modules_and_ssl.patch
	epatch ${FILESDIR}/${PN}-${PYVER}-mimetypes_apache.patch
	epatch ${FILESDIR}/${PN}-${PYVER}-db4.2.patch

	# prepends /usr/lib/portage/pym to sys.path
	epatch ${FILESDIR}/${PN}-${PYVER}-add_portage_search_path.patch

	epatch ${FILESDIR}/python-${PYVER}-libdir.patch
	sed -i -e "s:@@GENTOO_LIBDIR@@:$(get_libdir):g" \
		Lib/distutils/command/install.py \
		Lib/distutils/sysconfig.py \
		Lib/site.py \
		Makefile.pre.in \
		Modules/Setup.dist \
		Modules/getpath.c \
		setup.py
}

src_configure() {
	# disable extraneous modules with extra dependencies
	if use build; then
		export PYTHON_DISABLE_MODULES="readline pyexpat dbm gdbm bsddb _curses _curses_panel _tkinter"
		export PYTHON_DISABLE_SSL=1
	else
		use gdbm \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} gdbm"
		use berkdb \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} dbm bsddb"
		use readline \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} readline"
		( use !X || use !tcltk ) \
			&& PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} _tkinter"
		use ncurses \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} _curses _curses_panel"
		use ssl \
			|| export PYTHON_DISABLE_SSL=1
		export PYTHON_DISABLE_MODULES
		echo $PYTHON_DISABLE_MODULES
	fi
}

src_compile() {
	filter-flags -malign-double

	[ "${ARCH}" = "alpha" ] && append-flags -fPIC
	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	# http://bugs.gentoo.org/show_bug.cgi?id=50309
	if is-flag -O3; then
	   is-flag -fstack-protector-all && replace-flags -O3 -O2
	   use hardened && replace-flags -O3 -O2
	fi

	export OPT="${CFLAGS}"

	local myconf
	#if we are creating a new build image, we remove the dependency on g++
	if use build && ! use bootstrap; then
		myconf="--with-cxx=no"
	fi

	# super-secret switch. don't use this unless you know what you're
	# doing. enabling UCS2 support will break your existing python
	# modules
	use ucs2 \
		&& myconf="${myconf} --enable-unicode=ucs2" \
		|| myconf="${myconf} --enable-unicode=ucs4"

	src_configure

	econf --with-fpectl \
		--enable-shared \
		`use_enable ipv6` \
		--infodir='${prefix}'/share/info \
		--mandir='${prefix}'/share/man \
		--with-threads \
		${myconf} || die
	emake || die "Parallel make failed"
}

src_install() {
	dodir /usr
	src_configure
	make DESTDIR="${D}" altinstall  || die

	# install our own custom python-config
	exeinto /usr/bin
	newexe ${FILESDIR}/python-config-${PYVER} python-config

	# The stuff below this line extends from 2.1, and should be deprecated
	# in 2.3, or possibly can wait till 2.4

	# seems like the build do not install Makefile.pre.in anymore
	# it probably shouldn't - use DistUtils, people!
	insinto /usr/$(get_libdir)/python${PYVER}/config
	doins ${S}/Makefile.pre.in

	# While we're working on the config stuff... Let's fix the OPT var
	# so that it doesn't have any opts listed in it. Prevents the problem
	# with compiling things with conflicting opts later.
	dosed -e 's:^OPT=.*:OPT=-DNDEBUG:' \
			/usr/$(get_libdir)/python${PYVER}/config/Makefile

	# install python-updater in /usr/sbin
	dosbin ${FILESDIR}/python-updater

	if use build ; then
		rm -rf ${D}/usr/lib/python${PYVER}/{test,encodings,email,lib-tk,bsddb/test}
	else
		use uclibc && rm -rf ${D}/usr/lib/python${PYVER}/{test,bsddb/test}
		use berkdb || rm -rf ${D}/usr/lib/python${PYVER}/bsddb
		( use !X || use !tcltk ) && rm -rf ${D}/usr/lib/python${PYVER}/lib-tk
	fi

	prep_ml_includes usr/include/python${PYVER}
}

pkg_postrm() {
	python_makesym
	python_mod_cleanup /usr/lib/python${PYVER}
	[[ "$(get_libdir)" == "lib" ]] || python_mod_cleanup /usr/$(get_libdir)/python${PYVER}
}

pkg_postinst() {
	local myroot
	myroot=$(echo $ROOT | sed 's:/$::')


	python_makesym
	python_mod_optimize
	python_mod_optimize -x site-packages -x test ${myroot}/usr/lib/python${PYVER}
	[[ "$(get_libdir)" == "lib" ]] || python_mod_optimize -x site-packages -x test ${myroot}/usr/$(get_libdir)/python${PYVER}


	# workaround possible python-upgrade-breaks-portage situation
	if [ ! -f ${myroot}/usr/lib/portage/pym/portage.py ]; then
		if [ -f ${myroot}/usr/lib/python2.3/site-packages/portage.py ]; then
			einfo "Working around possible python-portage upgrade breakage"
			mkdir -p ${myroot}/usr/lib/portage/pym
			cp ${myroot}/usr/lib/python2.4/site-packages/{portage,xpak,output,cvstree,getbinpkg,emergehelp,dispatch_conf}.py ${myroot}/usr/lib/portage/pym
			python_mod_optimize ${myroot}/usr/lib/portage/pym
		fi
	fi

	echo
	ewarn
	ewarn "If you have just upgraded from an older version of python you will need to run:"
	ewarn
	ewarn "/usr/sbin/python-updater"
	ewarn
	ewarn "This will automatically rebuild all the python dependent modules"
	ewarn "to run with python-${PYVER}."
	ewarn
	ewarn "Your original Python is still installed and can be accessed via"
	ewarn "/usr/bin/python2.x."
	ewarn
	ebeep 5
}

