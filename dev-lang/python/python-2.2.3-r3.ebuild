# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.2.3-r3.ebuild,v 1.1 2003/10/17 07:22:21 liquidx Exp $

inherit flag-o-matic eutils python

IUSE="readline tcltk berkdb bootstrap build doc"

PYVER_MAJOR="`echo ${PV%_*} | cut -d '.' -f 1`"
PYVER_MINOR="`echo ${PV%_*} | cut -d '.' -f 2`"
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"

S="${WORKDIR}/Python-${PV}"
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PV%_*}/Python-${PV}.tgz"

HOMEPAGE="http://www.python.org"
LICENSE="PSF-2.2"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~ia64"

DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	doc? ( =dev-python/python-docs-${PV}* )
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )
	tcltk? ( >=dev-lang/tk-8.0 )
	|| ( dev-libs/expat
	     ( !build?     ( dev-libs/expat ) )
	     ( !bootstrap? ( dev-libs/expat ) )
	    )"
# This is a hairy one.  Basically depend on dev-libs/expat
# if "build" or "bootstrap" not in USE.

RDEPEND="${DEPEND} dev-python/python-fchksum"

# The dev-python/python-fchksum RDEPEND is needed to that this python provides
# the functionality expected from previous pythons.

PROVIDE="virtual/python"

SLOT="2.2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-db4.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.3-add_portage_search_path.patch
	epatch ${FILESDIR}/${PN}-2.2.3-gentoo_py_dontcompile.patch
}

src_compile() {
	filter-flags -malign-double

	[ "${ARCH}" = "hppa" ] && append-flags -fPIC
	[ "${ARCH}" = "alpha" ] && append-flags -fPIC
	export OPT="${CFLAGS}"

	# adjust makefile to install pydoc into ${D} correctly
	t="${S}/Makefile.pre.in"
	cp ${t} ${t}.orig || die
	sed 's:install-platlib.*:& --install-scripts=$(BINDIR):' ${t}.orig > ${t}

	local myopts
	#if we are creating a new build image, we remove the dependency on g++
	if [ "`use build`" -a ! "`use bootstrap`" ]
	then
		myopts="--with-cxx=no"
	fi

	# build python with threads support
	myopts="${myopts} --with-threads"

	econf --with-fpectl \
		--infodir='${prefix}'/share/info \
		--mandir='${prefix}'/share/man \
		${myopts} || die
	emake || die "Parallel make failed"
}

src_install() {
	dodir /usr
	make install prefix=${D}/usr || die

	rm -f ${D}/usr/bin/python
	dodoc README

	# install our own custom python-config
	exeinto /usr/bin
	newexe ${FILESDIR}/python-config-${PYVER} python-config

	# seems like the build do not install Makefile.pre.in anymore
	# it probably shouldn't - use DistUtils, people!
	insinto /usr/lib/python${PYVER}/config
	doins ${S}/Makefile.pre.in

	# While we're working on the config stuff... Let's fix the OPT var
	# so that it doesn't have any opts listed in it. Prevents the problem
	# with compiling things with conflicting opts later.
	dosed -e 's:^OPT=.*:OPT=-DNDEBUG:' /usr/lib/python${PYVER}/config/Makefile

	# If USE tcltk lets install idle
	# Need to script the python version in the path
	if [ -n "`use tcltk`" ]; then
		dodir /usr/lib/python${PYVER}/tools
		cp -r "${S}/Tools/idle" "${D}/usr/lib/python${PYVER}/tools/"
		dosym /usr/bin/idle.py /usr/lib/python${PYVER}/tools/idle/idle.py
	fi
}

pkg_postinst() {
	python_makesym
	PYTHON_OVERRIDE_PYVER="2.2" python_mod_optimize
	PYTHON_OVERRIDE_PYVER="2.2" python_mod_optimize -x site-packages ${ROOT}usr/lib/python${SLOT}
}

pkg_postrm() {
	python_makesym
	python_mod_cleanup
}
