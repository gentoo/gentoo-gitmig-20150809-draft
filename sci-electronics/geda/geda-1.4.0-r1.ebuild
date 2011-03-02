# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-1.4.0-r1.ebuild,v 1.4 2011/03/02 18:06:07 jlec Exp $

EAPI="1"

inherit eutils versionator

SUBDIR="v$(get_version_component_range 1-2)"
S="${WORKDIR}"

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="Core metapackage for all the necessary components you would need for a minimal gEDA/gaf system"
SRC_URI="http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-gattrib-${PV}.tar.gz
	http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-gnetlist-${PV}.tar.gz
	http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-gschem-${PV}.tar.gz
	http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-gsymcheck-${PV}.tar.gz
	http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-symbols-${PV}.tar.gz
	http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-utils-${PV}.tar.gz
	doc? ( http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-docs-${PV}.tar.gz )
	examples? ( http://www.geda.seul.org/release/${SUBDIR}/${PV}/geda-examples-${PV}.tar.gz )"

IUSE="doc examples gd threads"
LICENSE="GPL-2"
KEYWORDS="ppc"
SLOT="0"

DEPEND="
	x11-libs/gtk+:2
	>=dev-scheme/guile-1.6.3
	=sci-libs/libgeda-${PV}"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8" ; then
		built_with_use "dev-scheme/guile" deprecated \
			|| die "You need either <dev-scheme/guile-1.8, or >=dev-scheme/guile-1.8 with USE=deprecated"
	fi
	if use gd ; then
		built_with_use sci-libs/libgeda gd || die "sci-libs/libgeda must be compiled with USE=gd"
	else
		! built_with_use sci-libs/libgeda gd || die "sci-libs/libgeda must be compiled with USE=-gd"
	fi
}

src_unpack() {
	unpack ${A}
	# Fix security bug #247538 (CVE-2008-5148), thanks to Chitlesh Goorah
	sed -i \
		-e 's:TMP=/tmp/\$\$:TMP=$(mktemp):' \
		-e 's:>/tmp/\$\$:>${TMP}:' \
		"${S}"/geda-gnetlist-${PV}/scripts/sch2eaglepos.sh \
		|| die "sed failed"
	# fix for renamed members of GTKEntry from gtk+-2.17 on (see bug 323127)
	cd "${S}"/geda-gattrib-${PV}
	epatch "${FILESDIR}"/geda-gattrib-${PV}-gtkentry.patch
}

src_compile() {
	local myconf="--disable-threads"
	use threads || myconf="--enable-threads=posix"
	for subdir in geda-{symbols,gschem,gnetlist,gsymcheck,gattrib,utils}-${PV}; do
		cd "${S}/${subdir}"
		econf \
			${myconf} \
			--disable-dependency-tracking \
			--with-docdir=/usr/share/doc/${PF} \
			--with-pcbconfdir=/usr/share/pcb \
			--with-pcbm4dir=/usr/share/pcb/m4 \
			--disable-update-desktop-database \
			--disable-rpath \
			--with-x \
			|| die "Configuration failed in ${subdir}"
		emake || die "Compilation failed in ${subdir}"
	done

	if use doc ; then
		cd "${S}/geda-docs-${PV}"
		econf --with-docdir=/usr/share/doc/${PF} || die "Configuration failed in geda-docs-${PV}"
		emake || die "Compilation failed in geda-docs-${PV}"
	fi
}

src_install () {
	for subdir in geda-{symbols,gschem,gnetlist,gsymcheck,gattrib,utils}-${PV}; do
		cd "${S}/${subdir}"
		emake DESTDIR="${D}" install || die "Installation failed in geda-${subdir}-${PV}"
		newdoc AUTHORS AUTHORS.${subdir}
		newdoc BUGS BUGS.${subdir}
		for READMEx in $(ls README*); do
			newdoc ${READMEx} ${READMEx}.${subdir}
		done
	done

	rm "${D}"/usr/share/gEDA/sym/gnetman -Rf # Fix collision with gnetman; bug #77361.

	if use doc ; then
		cd "${S}"/geda-docs-${PV}
		emake DESTDIR="${D}" install || die "Installation failed in geda-docs-${PV}"
	fi

	if use examples ; then
		cd "${S}"
		mv geda-examples-${PV} examples
		insinto /usr/share/gEDA
		doins -r examples
	fi
}

src_postinst() {
	fdo-mime_desktop_database_update
}

src_postrm() {
	fdo-mime_desktop_database_update
}
