# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlzip/camlzip-1.01.ebuild,v 1.1 2004/08/18 12:01:52 mattam Exp $

IUSE=""

DESCRIPTION="Compressed file access ML library (ZIP, GZIP and JAR)"
HOMEPAGE="http://cristal.inria.fr/~xleroy/software.html#camlzip"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${PN}-${PV}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ocaml-3.04 \
		>=sys-libs/zlib-1.1.3 \
		sys-apps/sed \
		>=dev-ml/findlib-0.8"
RDEPEND=">=dev-ml/findlib-0.8"

src_unpack() {
	local CAT=$(which cat)
	local CP=$(which cp)
	local MV=$(which mv)
	local SED=$(which sed)

	unpack ${A}
	$CP /usr/lib/ocaml/ld.conf ${WORKDIR}
	# The ML linker configuration file is copied
	# into the ${WORKDIR} so as to compile properly
	# the ML related code.
	#
	# NB: Note that this file should NOT be copied
	# to the ${D}usr/lib/ocaml/ directory otherwise 
	# it would be deleted at camlzip's unmerge, 
	# which would break OCAML environment.
	# Julien TIERNY <julien.tierny@wanadoo.fr>
	$CAT ${S}/Makefile | \
		$SED "s/\`\$(OCAMLC) -where\`/\${D}\`ocamlfind\ printconf\ path\`/" | \
		$SED "s/ldconf=\${D}usr\/lib\/ocaml\/ld.conf;/ldconf=\${WORKDIR}\/ld.conf/" > \
		${S}/Makefile.tmp
	$MV ${S}/Makefile.tmp ${S}/Makefile
}

src_compile() {
	emake all || die "Failed at compilation step !!!"
	emake allopt || die "Failed at ML compilation step !!!"
}

src_install() {
	einstall || die "Failed at installation step !!!"
	emake installopt || die "Failed at ML related installation step !!!"
	dodoc README
	insopts -m 644
	insinto `ocamlfind printconf path`/zip
	doins ${FILESDIR}/META
}

pkg_postinst() {
	local ECHO=$(which echo)
	local CAT=$(which cat)
	local GREP=$(which grep)

	if [ -z `$CAT /usr/lib/ocaml/ld.conf | $GREP zip` ]
	then
		einfo "Patching OCAML linker configuration file..."
		$ECHO "`ocamlfind printconf path`zip" >> /usr/lib/ocaml/ld.conf
	fi
}
