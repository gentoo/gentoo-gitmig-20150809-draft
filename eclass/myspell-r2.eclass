# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/myspell-r2.eclass,v 1.1 2012/04/24 12:49:09 scarabeus Exp $

# @ECLASS: aspell-dict.eclass
# @MAINTAINER:
# app-dicts@gentoo.org
# @AUTHOR:
# Tomáš Chvátal <scarabeus@gentoo.org>
# @BLURB: An eclass to ease the construction of ebuilds for myspell dicts
# @DESCRIPTION:

inherit base

EXPORT_FUNCTIONS src_unpack src_install

# @ECLASS-VARIABLE: MYSPELL_DICT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array variable containing list of all dictionary files.
# MYSPELL_DICT=( "file.dic" "dir/file2.aff" )

# @ECLASS-VARIABLE: MYSPELL_HYPH
# @DESCRIPTION:
# Array variable containing list of all hyphenation files.
# MYSPELL_HYPH=( "file.dic" "dir/file2.dic" )

# @ECLASS-VARIABLE: MYSPELL_THES
# @DESCRIPTION:
# Array variable containing list of all thesarus files.
# MYSPELL_HYPH=( "file.dat" "dir/file2.idx" )

# Basically no extra deps needed.
# Unzip is required for .oxt libreoffice extensions
# which are just fancy zip files.
DEPEND="app-arch/unzip"
RDEPEND=""

# by default this stuff does not have any folder in the pack
S="${WORKDIR}"

# @FUNCTION: myspell-r2_src_unpack
# @DESCRIPTION:
# Unpack all variants of weird stuff.
# In our case .oxt packs.
myspell-r2_src_unpack() {
	local f
	for f in ${A}; do
		case ${f} in
			*.oxt)
				echo ">>> Unpacking ${f} to ${PWD}"
				unzip -qoj ${f}
				assert "failed unpacking ${f}"
				;;
			*) unpack ${f} ;;
		esac
	done
}

# @FUNCTION: myspell-r2_src_install
# @DESCRIPTION:
# Install the dictionaries to the right places.
myspell-r2_src_install() {
	local x
	
	# Following the debian directory layout here.
	# DICT: /usr/share/hunspell
	# THES: /usr/share/mythes
	# HYPH: /usr/share/hyphen
	# We just need to copy the required files to proper places.

	# TODO: backcompat dosym remove when all dictionaries and libreoffice
	#       ebuilds in tree use only the new paths

	insinto /usr/share/hunspell
	for x in "${MYSPELL_DICT[@]}"; do
		doins "${x}" || die
		dosym /usr/share/hunspell/"${x}" /usr/share/myspell/"${x}" || die
	done

	insinto /usr/share/mythes
	for x in "${MYSPELL_THES[@]}"; do
		doins "${x}" || die
		dosym /usr/share/mythes/"${x}" /usr/share/myspell/"${x}" || die
	done

	insinto /usr/share/hyphen
	for x in "${MYSPELL_HYPH[@]}"; do
		doins "${x}" || die
		dosym /usr/share/hyphen/"${x}" /usr/share/myspell/"${x}" || die
	done

	# Readme and so on
	dodoc *.txt || die
}
