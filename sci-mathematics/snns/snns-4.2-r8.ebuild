# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/snns/snns-4.2-r8.ebuild,v 1.7 2009/09/05 21:31:32 maekke Exp $

inherit eutils python multilib

MY_P="SNNSv${PV}"
MYPATCH="${P}-20040227"
MYPYTHONEXT="PySNNS-20040605"
MYPYTHONPATCH="PythonFunctionSupport-20050210.patch"

DESCRIPTION="Stuttgart Neural Network Simulator"
HOMEPAGE="http://www-ra.informatik.uni-tuebingen.de/SNNS/"
SRC_URI="http://www-ra.informatik.uni-tuebingen.de/downloads/SNNS/${MY_P}.tar.gz
	mirror://berlios/snns-dev/${MYPATCH}.patch.gz
	doc? ( http://www-ra.informatik.uni-tuebingen.de/downloads/SNNS/${MY_P}.Manual.pdf )
	python? ( mirror://berlios/snns-dev/${MYPYTHONEXT}.tar.gz
			  mirror://berlios/snns-dev/${MYPYTHONPATCH}.gz )"

LICENSE="SNNS-${PV}"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE="X doc python"

RDEPEND="X? ( x11-libs/Xaw3d )
	python? ( >=dev-lang/python-2.3 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	X? ( x11-proto/xproto )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	unpack ${MYPATCH}.patch.gz
	epatch ${MYPATCH}.patch
	if use python; then
		unpack ${MYPYTHONEXT}.tar.gz

		cd "${S}"
		epatch "${FILESDIR}"/${PV}-fPIC-python.patch
		cd "${WORKDIR}"
		unpack ${MYPYTHONPATCH}.gz
		cd "${S}"
		epatch "${WORKDIR}"/${MYPYTHONPATCH}
	fi
	cd "${S}"/xgui/sources
	for file in *.c; do
		sed -e "s:X11/Xaw/:X11/Xaw3d/:g" -i "${file}"
	done
}

src_compile() {
	local myconf="--enable-global"
	local compileopts="compile-kernel compile-tools"

	if use X; then
		myconf="${myconf} --with-x"
		compileopts="${compileopts} compile-xgui"
	else
		myconf="${myconf} --without-x"
	fi

	econf ${myconf} || die "econf failed"
	# parallel make sometimes fails (phosphan)
	make ${compileopts} || die "make failed"

	if use python; then
		python_version
		cd python
		${python} setup.py build || die "could not build python extension"
	fi
}

src_install() {
	for file in `find tools -type f -perm +100`; do
		dobin $file
	done

	mv "${D}/usr/bin/netperf" "${D}/usr/bin/snns-netperf"

	if use X; then
		newbin xgui/sources/xgui snns

		dodir /etc/env.d
		echo XGUILOADPATH=/usr/share/doc/${PF}/ > "${D}"/etc/env.d/99snns

		insinto /usr/share/doc/${PF}
		doins default.cfg help.hdoc
	fi

	if use python; then
		python_version
		cd python
		${python} setup.py install --prefix="${D}"/usr || die "could not install python module"
		cp -pPR examples "${D}"/usr/share/doc/${PF}/python-examples
		chmod +x "${D}"/usr/share/doc/${PF}/python-examples/*.py
		newdoc README README.python
		cd "${S}"
	fi

	insinto /usr/share/doc/${PF}
	use doc && doins "${DISTDIR}"/${MY_P}.Manual.pdf

	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	doman man/man*/*
}

pkg_postinst() {
	if use python; then
		einfo "Pre-compiling Python module"
		python_version
		for file in __init__.py util.py; do
			python_mod_compile \
				/usr/$(get_libdir)/python${PYVER}/site-packages/snns/${file}
		done
	fi
}

pkg_postrm() {
	if use python; then
		einfo "Cleaning up python stuff"
		python_mod_cleanup
	fi
}
