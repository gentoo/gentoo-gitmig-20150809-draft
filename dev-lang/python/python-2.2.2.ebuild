# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.2.2.ebuild,v 1.16 2004/07/14 13:46:04 agriffis Exp $

IUSE="berkdb bootstrap build readline tcltk"

PYVER_MAJOR="`echo ${PV} | cut -d '.' -f 1`"
PYVER_MINOR="`echo ${PV} | cut -d '.' -f 2`"
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
S="${WORKDIR}/Python-${PV}"
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PV}/Python-${PV}.tgz"

HOMEPAGE="http://www.python.org"
LICENSE="PSF-2.2"
KEYWORDS="x86 ppc sparc alpha mips hppa"

DEPEND="virtual/libc >=sys-libs/zlib-1.1.3
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

inherit flag-o-matic

src_compile() {
	filter-flags -malign-double

	[ "${ARCH}" = "hppa" ] && append-flags -fPIC

	if [ "${ARCH}" = "alpha" ]; then
		CFLAGS="${CFLAGS} -fPIC"
		CXXFLAGS="${CXXFLAGS} -fPIC"
	fi
	export OPT="${CFLAGS}"

	# adjust makefile to install pydoc into ${D} correctly
	t="${S}/Makefile.pre.in"
	cp ${t} ${t}.orig || die
	sed 's:install-platlib.*:& --install-scripts=$(BINDIR):' ${t}.orig > ${t}

	local myopts
	#if we are creating a new build image, we remove the dependency on g++
	if use build && ! use bootstrap
	then
		myopts="--with-cxx=no"
	fi

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
	dosym python${PYVER_MAJOR} /usr/bin/python
	dosym python${PYVER_MAJOR}.${PYVER_MINOR} /usr/bin/python${PYVER_MAJOR}
	dodoc README

	# install our own custom python-config
	exeinto /usr/bin
	newexe ${FILESDIR}/python-config-${PV} python-config

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
	if use tcltk; then
		dodir /usr/lib/python${PYVER}/tools
		mv "${S}/Tools/idle" "${D}/usr/lib/python${PYVER}/tools/"
		dosym /usr/lib/python${PYVER}/tools/idle/idle.py /usr/bin/idle.py
	fi
}
