# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.2.1-r2.ebuild,v 1.5 2002/08/14 03:57:07 murphy Exp $

PYVER_MAJOR="`echo ${PV} | cut -d '.' -f 1`"
PYVER_MINOR="`echo ${PV} | cut -d '.' -f 2`"
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
S=${WORKDIR}/Python-${PV}
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PV}/Python-${PV}.tgz"

HOMEPAGE="http://www.python.org"
LICENSE="PSF-2.2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )
	tcltk? ( >=dev-lang/tk-8.0 )"
if [ -z "`use build`" -a -z "`use bootstrap`" ]; then
	DEPEND="$DEPEND dev-libs/expat"
fi
RDEPEND="$DEPEND dev-python/python-fchksum"

# The dev-python/python-fchksum RDEPEND is needed to that this python provides
# the functionality expected from previous pythons.

PROVIDE="virtual/python"

SLOT="2.2"

src_compile() {
	export OPT="$CFLAGS"

	# adjust makefile to install pydoc into ${D} correctly
	t=${S}/Makefile.pre.in
	cp $t $t.orig || die
	sed 's:install-platlib.*:& --install-scripts=$(BINDIR):' $t.orig > $t
	
	local myopts
	#if we are creating a new build image, we remove the dependency on g++
	if [ "`use build`" -a ! "`use bootstrap`" ]
	then
		myopts="--with-cxx=no"
	fi
	
	econf --with-fpectl \
		--infodir='${prefix}'/share/info \
		--mandir='${prefix}'/share/man \
		$myopts || die
	emake || die "Parallel make failed"
}

src_install() {
	dodir /usr
	make install prefix=${D}/usr || die
	rm "${D}/usr/bin/python"
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

	# If USE tcltk lets install idle
	# Need to script the python version in the path
	if use tcltk; then
		mkdir "${D}/usr/lib/python${PYVER}/tools"
		mv "${S}/Tools/idle" "${D}/usr/lib/python${PYVER}/tools/"
		dosym /usr/lib/python${PYVER}/tools/idle/idle.py /usr/bin/idle.py
	fi
}
