# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.3.2-r2.ebuild,v 1.7 2003/12/24 04:24:20 bazik Exp $

inherit flag-o-matic python

MY_PV=${PV/_rc/c}
PYVER_MAJOR="`echo ${PV%_*} | cut -d '.' -f 1`"
PYVER_MINOR="`echo ${PV%_*} | cut -d '.' -f 2`"
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"

S="${WORKDIR}/Python-${MY_PV}"
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PV%_*}/Python-${MY_PV}.tgz"
HOMEPAGE="http://www.python.org"

IUSE="ncurses gdbm ssl readline tcltk berkdb bootstrap ipv6 build ucs2"
LICENSE="PSF-2.2"
SLOT="2.3"

KEYWORDS="~x86 ~ppc"
# "~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	!build? ( 	tcltk? ( >=dev-lang/tk-8.0 )
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

# this is to stop people shooting themselves in the foot. we can't
# add portage to DEPENDS otherwise it'll create a circular dependency
pkg_setup() {
	if ! has_version ">=sys-apps/portage-2.0.49-r16"; then
		eerror "Dependency Failed! Requires >=sys-apps/portage-2.0.49-r16"
		eerror "Please run: emerge portage"
		eerror "before proceeding. (NOTE: do not use -u if portage wants you to upgrade python)"
		die "Requires >=sys-apps/portage-2.0.49-r16"
	fi
}

src_unpack() {
	unpack ${A}
	# adds /usr/lib/portage/pym to sys.path - liquidx (08 Oct 03)
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.3-add_portage_search_path.patch
	# adds support for PYTHON_DONTCOMPILE shell environment to
	# supress automatic generation of .pyc and .pyo files - liquidx (08 Oct 03)
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.3-gentoo_py_dontcompile.patch
}

src_configure() {
	# disable extraneous modules with extra dependencies
	if [ -n "`use build`" ]; then
		export PYTHON_DISABLE_MODULES="readline pyexpat dbm gdbm bsddb _socket _curses _curses_panel _tkinter"
		export PYTHON_DISABLE_SSL=1
	else
		use gdbm \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} gdbm"
		use berkdb \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} dbm bsddb"
		use readline \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} readline"
		use tcltk \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} _tkinter"
		use ncurses \
			|| PYTHON_DISABLE_MODULES="${PYTHON_DISABLE_MODULES} _curses _curses_panel"
		use ssl \
			|| export PYTHON_DISABLE_SSL=1
		export PYTHON_DISABLE_MODULES
	fi
}

src_compile() {
	filter-flags -malign-double

	[ "${ARCH}" = "hppa" ] && append-flags -fPIC
	[ "${ARCH}" = "alpha" ] && append-flags -fPIC
	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	export OPT="${CFLAGS}"

	local myconf
	#if we are creating a new build image, we remove the dependency on g++
	if [ "`use build`" -a ! "`use bootstrap`" ]; then
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
	insinto /usr/lib/python${PYVER}/config
	doins ${S}/Makefile.pre.in

	# While we're working on the config stuff... Let's fix the OPT var
	# so that it doesn't have any opts listed in it. Prevents the problem
	# with compiling things with conflicting opts later.
	dosed -e 's:^OPT=.*:OPT=-DNDEBUG:' /usr/lib/python${PYVER}/config/Makefile

}

pkg_postrm() {
	python_makesym
	python_mod_cleanup /usr/lib/python2.3
}

pkg_postinst() {
	python_makesym
	python_mod_optimize
	python_mod_optimize -x site-packages -x test ${ROOT}usr/lib/python${PYVER}

	echo
	ewarn
	ewarn "If you have just upgraded from python-2.2.x you will need to run:"
	ewarn
	ewarn "${PORTDIR}/dev-lang/python/files/python-updater"
	ewarn
	ewarn "This will automatically rebuild all the python dependent modules"
	ewarn "to run with python-2.3."
	ewarn
	ewarn "Python 2.2 is still installed and can be accessed via /usr/bin/python2.2."
	ewarn "Portage-2.0.49-r8 and below will continue to use python-2.2.x, so"
	ewarn "think twice about uninstalling it, otherwise your system will break."
	ewarn
	echo -ne "\a"; sleep 1
	echo -ne "\a"; sleep 1
	echo -ne "\a"; sleep 1
	echo -ne "\a"; sleep 1
	echo -ne "\a"; sleep 1

}
