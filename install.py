import time
import os
import os.path

if __name__ == '__main__':
  df_path = os.getcwd()
  user_path = os.getenv('HOME')

  os.chdir(user_path)

  FILES = (
    (os.path.isfile, ('vimrc', 'profile', 'gitignore')),
    (os.path.isdir, ('vim',)),
    )
  stamp = int(time.time())

  for exists_method, file_list in FILES:
    for df in file_list:
      if exists_method(os.path.join(df_path, df)):
        if os.path.islink(os.path.join(user_path, '.' + df)):
          os.remove(os.path.join(user_path, '.' + df))
        if exists_method(os.path.join(user_path, '.' + df)):
          os.rename(os.path.join(user_path, '.' + df), os.path.join(user_path, '.' + str(stamp) + '.' + df))
        os.symlink(os.path.join(df_path, df), '.' + df)

