#
# /usr/share/php-select/libsymlink.sh
#		Library for managing PHP symlinks on Gentoo Linux
#
# Author	Stuart Herbert
#		(stuart@gentoo.org)
#
# Copyright	(c) 2005 Gentoo Foundation, Inc.
#		Released under v2 of the GNU General Public License
#
# ========================================================================

actionSet ()
{
	setSymlinks
}

actionShow ()
{
	showSymlinks
}

actionTest ()
{
	testSymlinks
}

# ------------------------------------------------------------------------
# buildTargets() - map source files to target files
#
# $1 - php topdir to map from
# $G_SYMLINK_SOURCE - array of files to map from
#
# echo's a list of files to map to - capture and turn into an array

buildTargets ()
{
	for (( i = 0 ; i < ${#G_SYMLINK_SOURCE[@]} ; i + i + 1 )) ; do
		echo "$1/${G_SYMLINK_SOURCE[$i]}"
	done
}

# ------------------------------------------------------------------------
# choosePhpVersion() - select which version of PHP to use for our files
#
# $1 - php version required
# $G_SYMLINK_SOURCE - array of files to look for
#
# returns 0 on success, 1 on failure
# echos the path to the PHP libdir containing the files on success

choosePhpVersion ()
{
	# which PHP versions supply our files?
	local choices
	choices=( $(learnPhpVersions) )

	# do we have the PHP version we want in our list of choices?
	for (( i = 0 ; i < ${#choices[@]} ; i = i + 1 )) ; do
		if [[ `basename ${choices[$i]}` == $1 ]] ; then
			echo "${choices[$i]}"
		fi
	done
}

# ------------------------------------------------------------------------
# hasCompatiblePhpVersions() - do we have compatible PHP versions installed
# or not?

hasCompatiblePhpVersions ()
{
	# find out which compatible PHP versions are installed (if any!)
	choices=$(learnPhpVersions)

	# if there are no installed php versions, we tell the user
	if [[ -z $choices ]] ; then
		echo "*** error: no compatible PHP version installed"
		G_EXITSTATUS=$G_STATUS_NOTINSTALLED
		return 1
	fi

	return 0
}

# ------------------------------------------------------------------------
# learnPhpVersions() - generate a list of valid PHP versions for this
# particular machine and component
#
# $G_SYMLINK_SOURCE - array of files to look for

learnPhpVersions ()
{
	local i
	local musthave
	local x
	local n

	# how many files are we looking for?
	musthave=${#G_SYMLINK_SOURCE[@]}

	for (( i = 0 ; i < ${#G_LIBDIR[@]} ; i = i + 1 )) ; do
		for x in `echo ${G_LIBDIR[$i]}/php*` ; do
			(( dohave = 0 ))

			for (( n = 0 ; n < musthave ; n = n + 1 )) ; do
				if [[ -f $x/${G_SYMLINK_SOURCE[$n]} ]] ; then
					(( dohave = dohave + 1 ))
				fi
			done

			if (( dohave == musthave )) ; then
				echo "$x"
			fi
		done
	done
}

# ------------------------------------------------------------------------
# learnSymlinks() - generate a list of where the files are symlinked to
#
# $G_SYMLINK_TARGET - array of files to look at

learnSymlinks ()
{
	for (( i = 0 ; i < ${#G_SYMLINK_TARGET[$i]} ; i = i + 1 )) ; do
		if [[ ! -e ${G_SYMLINK_TARGET[$i]} ]] ; then
			echo "Not_found"
		elif [[ ! -L ${G_SYMLINK_TARGET[$i]} ]] ; then
			echo "Not_link"
		else
			echo "$(readlink ${G_SYMLINK_TARGET[$i]})"
		fi
	done
}

# ------------------------------------------------------------------------
# setSymlinks () - set our target files to link to our source files
#
# $1 - PHP version to link to
# $G_SYMLINK_SOURCE - array of files to symlink to
# $G_SYMLINK_TARGET - array of symlink targets to create

setSymlinks ()
{
	# find out which compatible PHP versions are installed (if any!)
	hasCompatiblePhpVersions || return 1

	# find the directory holding the requested PHP version
	#
	# if we can't find the directory, tell the user which PHP
	# versions they can use with this module

	libdir=$(choosePhpVersion $G_PHPVERSION)
	if [[ -z $libdir ]] ; then
		echo "*** error: compatible php version not found"
		echo "Compatible versions are:"
		echo

		for (( i = 0 ; i < ${#choices[@]} ; i = i + 1 )) ; do
			echo "* `basename ${choices[$i]}`"
		done
	
		G_EXITSTATUS=$G_STATUS_NOTCOMPATIBLE
		return 1
	fi

	# we know where the file(s) are - create the symlinks

	for (( i = 0 ; i < ${#G_SYMLINK_SOURCE[@]} ; i = i + 1 )) ; do
		ln -sf ${libdir}/${G_SYMLINK_SOURCE[$i]} ${G_SYMLINK_TARGET[$i]}
	done
}

# ------------------------------------------------------------------------
# showSymlinks () - show the files that we link to
#
# $G_SYMLINK_TARGET - array of files that may be linked

showSymlinks ()
{
	# find out which compatible PHP versions are installed (if any!)
	hasCompatiblePhpVersions || return 1

	# find out where each symlink points
	files=( $(learnSymlinks) )

	for (( i = 0 ; i < ${#files[@]} ; i = i + 1 )) ; do
		if [[ ${files[$i]} == "Not_found" ]]; then
			echo "${G_SYMLINK_TARGET[$i]} is not set"
			if (( G_EXITSTATUS < $G_STATUS_USINGNONE )) ; then
				G_EXITSTATUS=$G_STATUS_USINGNONE
			fi
		elif [[ ${files[$i]} == "Not_link" ]] ; then
			echo "${G_SYMLINK_TARGET[$i]} is not a symlink"
			if (( G_EXITSTATUS < $G_STATUS_USINGOTHER )) ; then
				G_EXITSTATUS=$G_STATUS_USINGOTHER
			fi
		else
			echo "${G_SYMLINK_TARGET[$i]} is set to ${files[$i]}"
		fi
	done
}

# ------------------------------------------------------------------------
# testSymlinks () - test symlinks for a specified PHP version
#
# $G_SYMLINK_TARGET - array of files that may be linked
# $G_PHPVERSION     - PHP version to check against

testSymlinks ()
{
	# find out which compatible PHP versions are installed (if any!)
	hasCompatiblePhpVersions || return 1

	# find out where each symlink points
	files=( $(learnSymlinks) )

	for (( i = 0 ; i < ${#files[@]} ; i = i + 1 )) ; do
		if [[ ${files[$i]} == "Not_found" ]]; then
			echo "*** warning: ${G_SYMLINK_TARGET[$i]} does not exist"
			if (( G_EXITSTATUS < $G_STATUS_USINGNONE )) ; then
				G_EXITSTATUS=$G_STATUS_USINGNONE
			fi
		elif [[ ${files[$i]} == "Not_link" ]] ; then
			echo "*** warning: ${G_SYMLINK_TARGET[$i]} is not a symlink"
			if (( G_EXITSTATUS < $G_STATUS_USINGNONE )) ; then
				G_EXITSTATUS=$G_STATUS_USINGNONE
			fi
		else
			echo ${files[$i]} | grep $G_PHPVERSION > /dev/null 2>&1
			if [[ $? != 0 ]] ; then
				echo "*** warning: ${G_SYMLINK_TARGET[$i]} does not use $G_PHPVERSION"
				if (( G_EXITSTATUS < $G_STATUS_USINGOTHER )) ; then
					G_EXITSTATUS=$G_STATUS_USINGOTHER
				fi
			fi
		fi
	done

	if [[ $G_EXITSTATUS == 0 ]] ; then
		echo "Okay"
	fi
}
