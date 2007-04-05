# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-20070216.ebuild,v 1.3 2007/04/05 07:00:21 calchan Exp $

inherit eutils

S="${WORKDIR}"

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="geda is a core metapackage which compiles all the necessary components you would need for a minimal gEDA/gaf system"
SRC_URI="http://www.geda.seul.org/devel/${PV}/geda-gattrib-${PV}.tar.gz
	http://www.geda.seul.org/devel/${PV}/geda-gnetlist-${PV}.tar.gz
	http://www.geda.seul.org/devel/${PV}/geda-gschem-${PV}.tar.gz
	http://www.geda.seul.org/devel/${PV}/geda-gsymcheck-${PV}.tar.gz
	http://www.geda.seul.org/devel/${PV}/geda-symbols-${PV}.tar.gz
	http://www.geda.seul.org/devel/${PV}/geda-utils-${PV}.tar.gz
	doc? ( http://www.geda.seul.org/devel/${PV}/geda-docs-${PV}.tar.gz )
	examples? ( http://www.geda.seul.org/devel/${PV}/geda-examples-${PV}.tar.gz )"

IUSE="doc examples gd"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-scheme/guile-1.6.3
	=sci-libs/libgeda-${PV}"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8" ; then
		built_with_use "dev-scheme/guile" deprecated \
			|| die "You need either <dev-scheme/guile-1.8, or >=dev-scheme/guile-1.8 with USE=deprecated"
	fi
	use gd && built_with_use sci-libs/libgeda gd || die "sci-libs/libgeda must be compiled with USE=gd"
}

src_compile() {
	for subdir in geda-{gattrib,gnetlist,gschem,gsymcheck,symbols,utils}-${PV}; do
		cd ${S}/${subdir}
		econf \
			--disable-dependency-tracking \
			--with-docdir=/usr/share/doc/${PF} \
			--with-pcbconfdir=/usr/share/pcb \
			--with-pcbm4dir=/usr/share/pcb/m4 \
			|| die "Configuration failed in ${subdir}"
		emake || die "Compilation failed in ${subdir}"
	done

	if use doc ; then
		cd ${S}/geda-docs-${PV}
		econf --with-docdir=/usr/share/doc/${PF} || die "Configuration failed in geda-docs-${PV}"
		emake || die "Compilation failed in geda-docs-${PV}"
	fi
}

src_install () {
	for subdir in {gattrib,gnetlist,gschem,gsymcheck,symbols,utils}; do
		cd ${S}/geda-${subdir}-${PV}
		emake DESTDIR=${D} install || die "Installation failed in geda-${subdir}-${PV}"
		newdoc AUTHORS AUTHORS.${subdir}
		newdoc BUGS BUGS.${subdir}
		for READMEx in $(ls README*); do
			newdoc ${READMEx} ${READMEx}.${subdir}
		done
	done

	rm ${D}/usr/share/gEDA/sym/gnetman -Rf # Fix collision with gnetman; bug #77361.

	if use doc ; then
		cd ${S}/geda-docs-${PV}
		emake DESTDIR=${D} install || die "Installation failed in geda-docs-${PV}"
	fi

	if use examples ; then
		cd ${S}
		mv geda-examples-${PV} examples
		insinto /usr/share/gEDA
		doins -r examples
	fi
}
