# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/sparky/sparky-3.111.ebuild,v 1.5 2007/03/15 21:58:21 kugelfang Exp $

inherit eutils toolchain-funcs multilib python

DESCRIPTION="Graphical NMR assignment and integration program for proteins, nucleic acids, and other polymers"
HOMEPAGE="http://www.cgl.ucsf.edu/home/sparky/"
SRC_URI="http://www.cgl.ucsf.edu/home/sparky/distrib-3.110/${PN}-source-${PV}.tar.gz"
LICENSE="sparky"
SLOT="0"
# Note: this package will probably require significant work for lib{32,64},
# including parts of the patch.
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror"
RDEPEND="=dev-lang/python-2.3*
	=dev-lang/tk-8.4*
	|| ( app-shells/tcsh app-shells/csh )"
DEPEND="${RDEPEND}
	>=app-shells/bash-3
	net-misc/rsync"
S="${WORKDIR}/${PN}"

pkg_setup() {
# Install for specific pythons instead of whatever's newest.
# We build against 2.3, because sparky binary builds include 2.3.
# 2.4 returns an error message:
#Traceback (most recent call last):
#  File "<string>", line 1, in ?
#  File "/usr/lib/python2.4/site-packages/sparky/__init__.py", line 44, in start_session
#    tk = tkutil.initialize_tk(argv)
#  File "/usr/lib/python2.4/site-packages/sparky/tkutil.py", line 919, in initialize_tk
#    tk = Tkinter.Tk(display, program_name, program_class)
#  File "/usr/lib/python2.4/lib-tk/Tkinter.py", line 1569, in __init__
#    self.tk = _tkinter.create(screenName, baseName, className, interactive, wantobjects, useTk, sync, use)
#TypeError: create() takes at most 5 arguments (8 given)

	python="/usr/bin/python2.3"
	python_version

	arguments=( SPARKY="${S}" \
		SPARKY_INSTALL_MAC="" \
		SPARKY_INSTALL="${D}/usr" \
		PYTHON_PREFIX="${ROOT}usr" \
		PYTHON_VERSION="${PYVER}" \
		TK_PREFIX="${ROOT}usr" \
		TCLTK_VERSION="8.4" \
		CXX="$(tc-getCXX)" \
		CC="$(tc-getCC)" \
		INSTALL="rsync -avz" \
		INSTALLDIR="rsync -avz" )

	# It would be nice to get the docs versioned, but not critical
	#	DOCDIR="\$(SPARKY_INSTALL)/share/doc/${PN}" \
	# To get libdir working properly, we need to get makefiles respecting this
	#	PYDIR="\$(SPARKY_INSTALL)/$(get_libdir)/python\$(PYTHON_VERSION)/site-packages" \
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/fix-install.patch

	sed -i \
		-e "s:^\(set PYTHON[[:space:]]*=\).*:\1 /usr/bin/python${PYVER}:g" \
		-e "s:^\(setenv TCLTK_LIB[[:space:]]*\).*:\1 /usr/$(get_libdir):g" \
		${S}/bin/sparky
}

src_compile() {
	emake "${arguments[@]}" || die "make failed"
}

src_install() {
	make "${arguments[@]}" install || die "install failed"
	# Make internal help work
	dosym ../../share/doc/sparky/manual /usr/lib/sparky/manual
	# It returns a weird threading error message without this
	dosym ../python${PYVER}/site-packages /usr/lib/sparky/python
}

pkg_postinst() {
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/sparky
}
